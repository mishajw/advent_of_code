#!/usr/bin/env python

with open("inputs/day1.txt", "r") as f:
    ns = "".join(f).strip()
ns += ns[0]

print(sum(int(i) for i, j in zip(ns[:-1], ns[1:]) if i == j))

