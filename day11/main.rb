require "set"

grid = ARGF.read.chomp.lines.map { |l| l.chomp.chars.map(&:to_i) }

def neighboring_cells(grid, x, y)
  [
    [x - 1, y - 1],
    [x - 1, y],
    [x - 1, y + 1],
    [x, y - 1],
    [x, y + 1],
    [x + 1, y - 1],
    [x + 1, y],
    [x + 1, y + 1]
  ].select { |_x, _y| _x >= 0 && _y >= 0 && _x < grid[0].size && _y < grid.size }
end

def each_grid_index(grid)
  grid.each_with_index do |row, y|
    row.each_with_index do |_, x|
      yield x, y
    end
  end
end

flashes = 0
steps = 0

loop do
  each_grid_index(grid) { |x, y| grid[y][x] += 1 }

  flashed = []
  each_grid_index(grid) { |x, y| flashed << [x, y] if grid[y][x] > 9 }
  flashes += flashed.size

  # increase the neighboring cells to all the flashed cells
  until flashed.empty?
    x, y = flashed.pop
    neighboring_cells(grid, x, y).each do |_x, _y|
      grid[_y][_x] += 1
      if grid[_y][_x] == 10
        flashed << [_x, _y]
        flashes += 1
      end
    end
  end

  # reset all flashed cells to 0
  each_grid_index(grid) { |x, y| grid[y][x] = 0 if grid[y][x] > 9 }

  steps += 1

  # part 1
  if steps == 100
    puts flashes
  end

  # part 2
  if grid.all? { |row| row.all? { |cell| cell == 0 } }
    puts steps
    break
  end
end
