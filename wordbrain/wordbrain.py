#!/usr/local/bin/python
import sys
import itertools as it
import copy

def solve(board, *lengths):
    words = []
    for length in lengths:
        for i in xrange(len(board)):
            for j in xrange(len(board)):
                words += solve_single(copy.deepcopy(board), length, '', (i,j))
    return words

def adjacencies(pos):
    offsets = [-1, 0, 1]
    return [tuple(x + y for x,y in zip(pos, offset)) for offset in it.product(offsets, offsets) if offset != (0,0)]

def solve_single(board, length, so_far, curr):
    if length == 0:
        return [so_far]
    valid = ((x, y) for x, y in adjacencies(curr) if x >= 0 and x < len(board) and y >= 0 and y < len(board))
    words = []
    for x,y in valid:
        if board[x][y] == None:
            continue
        new_board = copy.deepcopy(board)
        letter = new_board[x][y]
        new_board[x][y] = None
        words += solve_single(new_board, length - 1, so_far + letter, (x,y))
    return words

def assert_uniform(board):
    if not all([len(x) == len(board) for x in board]):
        raise Exception("Not uniform")

if len(sys.argv) <= 3:
    print "Call with: ./$SCRIPT $BOARD, $LENGTHS..."
    sys.exit(1)
board = eval(sys.argv[1])
assert_uniform(board)
result = solve(board, *[int(x) for x in sys.argv[2:]])
result.sort()
for r in result:
    print r
