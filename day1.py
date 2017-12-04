#!/usr/bin/env python

def repeated_sum(s, n: int) -> int:
    return sum(int(i) for i, j in zip(s, (s + s)[n:len(s) + n]) if i == j)

with open("inputs/day1.txt", "r") as f:
    numbers = "".join(f).strip()

print(f"Part one: {repeated_sum(numbers, 1)}")
print(f"Part two: {repeated_sum(numbers, int(len(numbers) / 2))}")

