# Create a two dimensional array from the puzzle
#
# puzzle - a string of 81 characters representing the puzzle
#
# Returns a two dimensional array (9x9) representing the puzzle
def create_2d_array_from_puzzle(puzzle)
  one_d_array = puzzle.split ''
  two_d_array = []
  shadow_array = []

  one_d_array.each.with_index do |n, i|
    shadow_array.push n.to_i

    if (i % 9 == 8) # start a new row
      two_d_array.push shadow_array.clone
      shadow_array.clear
    end
  end

  two_d_array
end

# Print the grid to the console
#
# grid - a two dimensional array representing the puzzle
#
# Example
#
#   2 3 4 | 5 7 1 | 6 9 8
#   9 7 6 | 2 3 8 | 4 1 5
#   5 8 1 | 9 6 4 | 2 3 7
#   ------+-------+------
#   3 2 7 | 4 9 5 | 8 6 1
#   6 9 5 | 1 8 3 | 7 4 2
#   4 1 8 | 7 2 6 | 3 5 9
#   ------+-------+------
#   7 4 2 | 3 5 9 | 1 8 6
#   1 6 9 | 8 4 7 | 5 2 3
#   8 5 3 | 6 1 2 | 9 7 4
def print_grid(grid)
  vertical_padding = ' '
  horizontal_padding = "\n"
  vertical_square_padding = '| '
  horizontal_square_padding = "------+-------+------\n"
  printable_grid = ''

  # loop through two dimensional array
  grid.each.with_index do |n, i|

    # loop through one dimensional array
    n.each.with_index do |h, j|
      printable_grid += h.to_s;
      printable_grid += vertical_padding

      # add vertical line after three numbers
      if (j % 3 == 2 && j % 9 != 8)
        printable_grid += vertical_square_padding
      end
    end

    # start a new row after nine numbers
    printable_grid += horizontal_padding

    # add a horizontal line after three rows
    if (i % 3 == 2 && i % 9 != 8)
      printable_grid += horizontal_square_padding
    end
  end

  puts printable_grid
end

# Check if the given puzzle is valid
#
# puzzle - a string that contains the puzzle
#
# Returns a boolean that indicates whether it's a valid puzzle or not
def puzzle_is_valid(puzzle)
  puzzle.length == 81
end

# Check if the number is not yet in the row
#
# grid - a two dimensional array representing the puzzle
# row - the row to check
# num - to number that needs to be checked
#
# Returns a boolean that indicates whether the number is already in the given row or not
def in_row(grid, row, num)
  grid[row].include? num
end

# Check if the number is not yet in the column
#
# grid - a two dimensional array representing the puzzle
# col - the column to check
# num - to number that needs to be checked
#
# Returns a boolean that indicates whether the number is already in the given column or not
def in_col(grid, col, num)
  grid.each do |row|
    if (row[col] == num)
      return true
    end
  end
  false
end

# Check if the number is not yet in the 3x3 box
#
# grid - a two dimensional array representing the puzzle
# row - the row to check
# col - the column to check
# num - to number that needs to be checked
#
# Returns a boolean that indicates whether the number is already in the 3x3 box or not
def in_box(grid, row, col, num)
  for i in 0..2 do
    for j in 0..2 do
      if (grid[i + row][j + col] == num)
        return true
      end
    end
  end
  false
end

# Check if it is safe to assign the number to the given location
#
# grid - a two dimensional array representing the puzzle
# row - the locations row
# col - the locations col
# num - the number to be assigned to the location
#
# Returns a boolean that indicates whether it is safe to assign a number to a location
def is_safe(grid, row, col, num)
  !in_row(grid, row, num) &&
  !in_col(grid, col, num) &&
  !in_box(grid, row - row % 3 , col - col % 3, num);
end

# Find a location that is still empty
#
# grid - a two dimensional array representing the puzzle
#
# Returns an array which contains the row and column of an empty location
def find_empty_location(grid)
  empty_location = []

  grid.each.with_index do |row, i|
    break unless row.each.with_index do |col, j|
      if (col == 0)
        empty_location.push i
        empty_location.push j
        break
      end
    end
  end
  empty_location
end

# Solve the sudoku
#
# grid - a two dimensional array representing the puzzle
#
# Returns the solved puzzle if solved, otherwise an empty array
def solve_sudoku(grid)
  empty_location = find_empty_location(grid)
  row = empty_location[0]
  col = empty_location[1]

  # the sudoku has been solved if there is no empty location anymore
  if (empty_location.empty?)
    return grid;
  end

  # loop through all possible numbers
  for i in 1..9 do

    # check if the number may be assigned to this location
    if (is_safe(grid, row, col, i))

      # make assignement and keep solving
      grid[row][col] = i
      partially_solved = solve_sudoku(Marshal.load(Marshal.dump(grid)))

      if (!partially_solved.empty?)
        return partially_solved
      end
    end
  end
  []
end

# Main method
if __FILE__ == $PROGRAM_NAME

  # get the puzzle from the command line arguments (or use the default puzzle)
  puzzle = ARGV[0]
  puzzle ||= '004071090976030000501960000307405000090100000000006009040050100169847000053012000'

  # track time
  start_time = Time.now

  if (puzzle_is_valid(puzzle))

    # create a two dimensional grid from the puzzle
    grid = create_2d_array_from_puzzle(puzzle)
    solved_puzzle = solve_sudoku(grid)

    if (solved_puzzle.any?)
      print_grid(solved_puzzle)
    else
      puts 'No solution possible'
    end
  else
    puts 'Invalid puzzle'
  end

  puts "Solved in #{Time.now - start_time} seconds"
end
