#!/usr/bin/env python3
#
# Convert .itermcolors plist files to hex colors for html.
#
# This file was originally based on the implementation here:
#   https://gist.github.com/MSylvia/4e90860743f1a4de187d
# and then modified to use Python 3 and the `plistlib` library.

from pathlib import Path
from plistlib import load as load_plist
from typing import Dict, Iterator, Tuple


BLUE = "Blue Component"
GREEN = "Green Component"
RED = "Red Component"


def dict_from_plist_file(plistfile: Path) -> Dict:
    with open(plistfile, 'rb') as pf:
        return load_plist(pf)


def rgb_to_hex(r: int, g: int , b: int ) -> str:
    return f"#{r:02X}{g:02X}{b:02X}"


def component_to_int(c: str) -> int:
    return int(float(c) * 255.0)


def key_color_pairs(plistfile: Path) -> Iterator[Tuple[str, str]]:
    for key, components in dict_from_plist_file(plistfile).items():
        r = component_to_int(components[RED])
        g = component_to_int(components[GREEN])
        b = component_to_int(components[BLUE])
        yield (key, rgb_to_hex(r, g, b))


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('plistfile', type=Path)
    args = parser.parse_args()

    for key, color in key_color_pairs(args.plistfile):
        print(f"{color}  // {key}")
