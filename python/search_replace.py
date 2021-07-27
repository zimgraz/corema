"""Replace defined terms in an text file by annotated versions of the terms.

Core feature is a tokenizer which is aware of multi-line terms.
"""
import csv
import re
#from fuzzywuzzy import fuzz
#if fuzz.ratio(str_a, test) > 75:

# These files contain data for annotations
TERMFILES = [
    "../ingredients/all-ingredient-in-corema.csv",
    "../tools/all-tool-in-corema.csv",
    "../dishes/all-dish-in-corema.csv",
]

OUTPUT_FILE = "../../Handschriften/Er2/Er2_annotated_detail.xml" # Output mauell hin- und herkopieren, damit keine Änderungen überschrieben werden 
INPUT_FILE = "../../Handschriften/Er2/Er2_annotated_phrase.xml" # HS Sigle anpassen 
SPLIT_AT = "()[]!?.,:;=\"'"


def split_termlist(tlist):
    """Create a list of lists containing all combinations of a mutli word term.

    So ["a b c", "d"] will result in
        [["a"], ["a", "b"], ["a", "b", "c"], ["d"]]
    """
    rval = []
    for term in tlist:
        tokens = term.split()
        for i in range(1, len(tokens) + 1):
            rval.append(tokens[0:i])
    return rval


def make_multi_token_lookup_table(termlist):
    """Create a dictionary containing token combinations for each entry of termlist.


    So ["a b c", "d"] will result in
        {
            'a': False,
            'a ': False,
            'a b':False,
            'a b ': False,
            'a b c': True,
            'd': True
        }

    the value is only True if the multi-token is the full entry
    """
    # remove double entries
    termset = set(termlist)
    # to have the list sorted is important to avoid that longer term overwrite existing entries
    termlist = sorted(termset, key=lambda x: (len(x), x))
    lookup_table = {}
    for item in termlist:
        lower_item = item.lower()
        tokens = re.split(r"(\s)", lower_item)
        tokens_buffer = []
        for token in tokens:
            tokens_buffer.append(token)
            tokens_so_far = "".join(tokens_buffer)
            if tokens_so_far not in lookup_table:
                is_term = tokens_so_far == lower_item
                lookup_table[tokens_so_far] = is_term
    return lookup_table


def split_tokens(txt, respect_tags=True):
    """A custom splitter which yields each token from text using chars from SPLIT_AT.

    It also returns splitting chars as tokens. 

    :param txt: The text to split
    :type txt: str
    :param repect_tags: If True, tags (everything inside a pair of angle brackets) 
                        are handled as single tokens
    :type respect_tags: bool
    'yields': token after token
    """
    token_buffer = []
    if not respect_tags:  # tags are not handled specially
        split_at = SPLIT_AT + "<>"
        for i, char in enumerate(txt):
            if (char in split_at or char.isspace()) and (i == 0 or txt[i - 1] != "\\"):
                if token_buffer:
                    yield "".join(token_buffer)
                    token_buffer = []
                yield char
            else:
                token_buffer.append(char)
    else:  # handle tags as single token
        in_tag = False
        for i, char in enumerate(txt):
            if in_tag:
                token_buffer.append(char)
                if char == ">":
                    yield "".join(token_buffer)
                    token_buffer = []
                    in_tag = False
            else:
                if char == "<":
                    if token_buffer:
                        yield "".join(token_buffer)
                        token_buffer = []
                    token_buffer.append(char)
                    in_tag = True
                elif (char in SPLIT_AT or char.isspace()) and (i == 0 or txt[i - 1] != "\\"):
                    if token_buffer:
                        yield "".join(token_buffer)
                        token_buffer = []
                    yield char
                else:
                    token_buffer.append(char)
    if token_buffer:  # yield remaining token
        yield "".join(token_buffer)


def split_longest_term(tokens, term_constitutes):
    """Find the longest term defined in term_constitutes in a list of tokens.

    This function returns the longest multi-token term definied in term_constitutes.
    It also returns a list of all remaining tokens which are not part of the term.
    
    Example: if 'a b' is in term_constitutes, and tokens is ['a', ' ', 'b', ' ', 'c'],
    then this function will return ('a b', [' ', 'c'])

    :param tokens: a list of tokens which where found to contain a term (plus at least one extra token). 
    :param term_constitutes: a dict containing all term and subterms (see make_multitoken_lookup_table)
    """
    term = None
    remaining_tokens = tokens
    for i in range(len(tokens), 0, -1):
        possible_term = "".join(tokens[0:i])
        if term_constitutes.get(possible_term.lower(), False): 
            term = possible_term
            remaining_tokens = tokens[i:]
            break
    return term, remaining_tokens


def tokenize_with_terms(txt, terms):
    """Tokenize txt by using every term in terms as token.

    Yields one token after the other, where token is either a single token
    in common meaning or a "term". "Terms" are single or multi-token
    strings defined in terms.

    So this tokenizer return tokens which are terms (if found) or normal tokens.
    If two defined terms overlap (like 'foo' and 'foo bar'), the tokinizer returns
    the longest term found (so here 'foo bar' if is exists in the text).

    With every token comes a boolean value which indicates if the
    token is contained in termlist or not. So
    `token, True` means that token is a term, where
    `token, False` means that token is not a term.

    :param txt: The text to be tokenized
    :type txt: str
    :param terms: A list of defined terms
    :type terms: list
    """
    term_constitutes = make_multi_token_lookup_table(terms)

    tokens_found = []
    for token in split_tokens(txt):
        if not tokens_found or ("".join(tokens_found) + token).lower() in term_constitutes:
            tokens_found.append(token)
            token = None
        else: # we found a token which does not match
            term_found, remaining_tokens = split_longest_term(tokens_found, term_constitutes)
            if term_found:
                if token:
                    tokens_found = remaining_tokens + [token] # TODO: deep copy?
                    token = None
                else:
                    tokens_found = remaining_tokens # TODO: deep copy?
                yield term_found, True
            else: 
                if remaining_tokens:
                    if token:
                        tokens_found = remaining_tokens + [token]# TODO: deep copy?
                        token = None
                    else:
                        tokens_found = remaining_tokens # TODO: deep copy?
                    yield tokens_found.pop(0), False
    while tokens_found:
        term, tokens_found = split_longest_term(tokens_found, term_constitutes)
        if term:
            yield term, True
        else:
            x =  tokens_found.pop(0), False
            yield x


def make_term_lookup_table(csv_data):
    """Make all terms from csv_data accessible by term.lower().

    csv_data contains a list of terms, each with additional data like translations etc.
    To speed up finding data for a term (+extra data) we put them into a dict,
    with term names in lower case as key.

    Keys are the values of the first column both in original spelling
    as in lowercase. So csv-data like::

        Foo,1,5
        Bar,4,2

    becomes::

        {
            'foo': {'Foo', '1', '5'},
            'bar': {'Bar', '4', '2'}
        }

    :param csv_data: An iterable which provides list (like lines from a csv file).
    :type csv_data: iterable
    :return: A dict using the first value of each line in lower case as key
    """
    lookup_dict = {}
    for line in csv_data:
        lookup_dict[line[0].lower().strip()] = line
    return lookup_dict


def extract_entity_name(filename):
    """Extract entity name from file name.

    Convert eg. `all-ingredient-in-corema.csv` to `ingredient`.
    """
    match = re.search(r"all-(.*?)-in", filename)
    if match:
        return match.group(1)
    raise ValueError("Cannot extract entity name from '{}'".format(filename))


def run(xml):
    """Apply all term files on xml.
    """
    xml = re.sub(r'\s+', ' ', xml)
    for filename in TERMFILES:
        entity_name = extract_entity_name(filename)
        with open(filename, "r", encoding="utf8") as csv_file:
            term_data = make_term_lookup_table(csv.reader(csv_file, delimiter=","))
        results = []
        for token, needs_annotation in tokenize_with_terms(xml, term_data.keys()):
            if needs_annotation:
                data = term_data[token.lower()]
                if data[2]!='':
                    results.append(
                        '<{entity} en="{en}" commodity="{wiki}" warning="{warning}">{token}</{entity}>'.format(
                            token=token, en=data[1], entity=entity_name, wiki=data[3], warning=data[2]
                        )
                    )
                else:
                    results.append(
                        '<{entity} en="{en}" commodity="{wiki}">{token}</{entity}>'.format(
                            token=token, en=data[1], entity=entity_name, wiki=data[3]
                        )
                    )
            else:
                results.append(token)
        xml = "".join(results)
       
    return xml


if __name__ == "__main__":
    with open(INPUT_FILE, "r", encoding="utf8") as fh_in:
        with open(OUTPUT_FILE, "w", encoding="utf8") as fh_out:
            fh_out.write(run(fh_in.read()))
