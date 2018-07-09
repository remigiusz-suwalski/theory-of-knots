#!/usr/bin/env python3

import re
import sys

def strip_year(text):
    return int("".join(filter(lambda ch: ch not in " {},", text)))

def sort_key(entry):
    name = entry["bibtex_name"]
    year = strip_year(entry["year"])
    return "{} {}".format(year, name)

def print_nicely(lst):
    for entry in lst:
        bibtex_name = entry.pop("bibtex_name")
        bibtex_type = entry.pop("bibtex_type")
        print ("@{} {{{},".format(bibtex_type, bibtex_name))
        tags = sorted(["    {} = {}".format(key, entry[key]) for key in entry])
        print("\n".join(tags))
        print ("}\n")

def parse_bib(bib_file):
    entries = dict()
    with open(bib_file, "r") as f:
        for raw_line in f:
            line = raw_line.strip()
            match = re.search(" *@([^ ]+) *{ *([^,]+),", line)
            if match:
                # when line is: "@article {alexander28,"
                bibtex_type = match.group(1).lower()
                bibtex_name = match.group(2)
                entries[bibtex_name] = {
                    "bibtex_type": bibtex_type,
                    "bibtex_name": bibtex_name
                }

            match = re.search(" *([a-zA-Z]+) *= *(.*)", line)
            if match:
                # when line is: "    author = {Alexander, J. W.},"
                key = match.group(1).lower()
                value = match.group(2)
                entries[bibtex_name][key] = value
    return entries

raw_entries = parse_bib(sys.argv[1])
sorted_entries = sorted(list(raw_entries.values()), key=sort_key)
print_nicely(sorted_entries)
