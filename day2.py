#!/usr/bin/env python

from itertools import permutations

with open("inputs/day2.txt", "r") as f:
    nums = [list(map(int, l.split("\t"))) for l in f if l.strip() != ""]

print(sum(map(lambda r: max(r) - min(r), nums)))
print(sum([a // b for a, b in permutations(row, 2) if a % b == 0][0] for row in nums))

