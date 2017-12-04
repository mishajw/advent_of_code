#!/usr/bin/env python

import sys
from math import ceil, sqrt

assert len(sys.argv) == 2, f"Usage: {sys.argv[0]}: <number>"
num = int(sys.argv[1])

ring = ceil(ceil(sqrt(num) - 1) / 2)
lower_sq = (ring * 2 - 1) ** 2
print(ring + abs(ring - ((num - lower_sq) % (ring * 2))))

