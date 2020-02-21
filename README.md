# sudoku-solver

## Prerequisites
-   Ruby - Download and install [Ruby](https://www.ruby-lang.org/en/downloads/)

## Getting Started
The solver can be used via the command line, simply run `ruby solver.rb`. This will solve the default puzzle. It is also possible to pass a puzzle: `ruby solver.rb 004071090976030000501960000307405000090100000000006009040050100169847000053012000`.

The result of your puzzle will be printed to the console.

    2 3 4 | 5 7 1 | 6 9 8
    9 7 6 | 2 3 8 | 4 1 5
    5 8 1 | 9 6 4 | 2 3 7
    ------+-------+------
    3 2 7 | 4 9 5 | 8 6 1
    6 9 5 | 1 8 3 | 7 4 2
    4 1 8 | 7 2 6 | 3 5 9
    ------+-------+------
    7 4 2 | 3 5 9 | 1 8 6
    1 6 9 | 8 4 7 | 5 2 3
    8 5 3 | 6 1 2 | 9 7 4
