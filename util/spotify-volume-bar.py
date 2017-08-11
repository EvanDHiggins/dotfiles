#!/usr/local/bin/python

from __future__ import print_function
import subprocess as s
import os

def bar_for_int(n):
    display_str = '|'
    floor_mul_five = n - (n % 5)
    display_str += int(floor_mul_five / 10) * '='
    if floor_mul_five % 2 == 1:
        display_str += '-'
    padding_len = 11 - len(display_str)
    return display_str + (' ' * padding_len) + '|'


if __name__ == "__main__":
    vol = int(s.check_output(['~/dotfiles/util/spotify-volume'], shell=True))
    print(vol)
    print(bar_for_int(vol))
