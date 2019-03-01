#!/usr/bin/env python3
"""
This script opens .bib file and sorts it's entries by year
"""

import os
import logging
import re
import sys

def strip_year(text):
    """Filter non-digit characters and convert to int"""

    return int("".join([ch for ch in text if ch not in " {},"]))


def sort_key(entry):
    """Print 'year name', key for sorting function"""

    name = entry["bibtex_name"]
    year = strip_year(entry["year"])
    output = "{} {}".format(year, name)

    logging.info("sort_key => {}".format(output))
    return output


def print_nicely(lst):
    """Convert list of dicts into nice .bib content"""

    output = ""
    for entry in lst:
        bibtex_name = entry.pop("bibtex_name")
        bibtex_type = entry.pop("bibtex_type")
        tags = sorted(["    {} = {}".format(key, entry[key]) for key in entry])
        output += "@{} {{{},\n".format(bibtex_type, bibtex_name)
        output += "\n".join(tags)
        output += "\n}\n\n"
    return output


def parse_bib(input_bib_file):
    """Converts .bib file into list of entries"""
    entries = dict()
    with open(input_bib_file, "r") as bib_file:
        for raw_line in bib_file:
            line = raw_line.strip()
            match = re.search(" *@([^ ]+) *{ *([^,]+),", line)
            if match:
                # when line is: "@article {alexander28,"
                bibtex_type = match.group(1).lower()
                bibtex_name = match.group(2)
                logging.info("parse_bib => type {} name {}".format(bibtex_type, bibtex_name))

                entries[bibtex_name] = {
                    "bibtex_type": bibtex_type,
                    "bibtex_name": bibtex_name
                }

            match = re.search(" *([a-zA-Z]+) *= *(.*)", line)
            if match:
                # when line is: "    author = {Alexander, J. W.},"
                key = match.group(1).lower()
                value = match.group(2)
                logging.info("parse_bib => key {} value {}".format(key, value))

                entries[bibtex_name][key] = value
    return entries


def bibliography_sort(input_bib_file):
    """Main function sorting bibliography entries"""

    logging.basicConfig(level=logging.DEBUG, format="%(levelname)s: %(message)s")
    logging.info("X")
    entries = parse_bib(input_bib_file)
    entries = sorted(list(entries.values()), key=sort_key)
    with open(input_bib_file, "w") as output_bib_file:
        output_bib_file.write(print_nicely(entries))


if __name__ == "__main__":
    BIB_FILE = os.path.abspath(
        os.path.join(sys.path[0], "..", "src", "knot_theory.bib")
    )
    bibliography_sort(BIB_FILE)
