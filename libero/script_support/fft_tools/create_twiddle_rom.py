import math

SCALE = 1 << 16
MASK = (1 << 18) - 1

with open("twiddle.hex", "w") as f:
    for k in range(512):
        angle = 2 * math.pi * k / 1024

        real = round(math.cos(angle) * SCALE)
        imag = round(-math.sin(angle) * SCALE)

        word = ((real & MASK) << 18) | (imag & MASK)
        f.write(f"{word:09X}\n")