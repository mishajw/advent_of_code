#!/usr/bin/env python

from typing import List

def count_valid(lines: List[List[str]]) -> int:
    return len(list(filter(lambda w: len(w) == len(set(w)), lines)))

with open("inputs/day4.txt") as f:
    lines = [line.strip().split(" ") for line in f]

print(count_valid(lines))
lines = [[str(sorted(w)) for w in words] for words in lines]
print(count_valid(lines))

