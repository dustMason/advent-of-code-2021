require "set"

input = ARGF.read.lines.map { |line| line.chomp.chars.map(&:to_i) }

grid = []
input.each_with_index do |row, y|
  grid[y] = []
  row.each_with_index do |cell, x|
    grid[y][x] = cell
  end
end

# part 1

sum = 0
low_points = []
grid.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    adjacent = []
    adjacent << grid[y-1][x] if y > 0
    adjacent << grid[y+1][x] if y < grid.size - 1
    adjacent << grid[y][x-1] if x > 0
    adjacent << grid[y][x+1] if x < row.size - 1
    # if all of the adjacent cells are larger, add the current cell to the sum
    if adjacent.all? { |c| c > cell }
      sum += cell + 1
      low_points << [x, y]
    end
  end
end
puts sum

# part 2

def border(grid, x, y)
  x < 0 || y < 0 || x >= grid[0].size || y >= grid.size || grid[y][x] == 9
end

# for each low point, do a breadth first search that stops when it finds 9
basins = low_points.map do |x, y|
  queue = [[x, y]]
  visited = Set.new
  until queue.empty?
    x, y = queue.shift
    visited.add([x, y])
    [[x+1, y], [x-1, y], [x, y-1], [x, y+1]].each do |xx, yy|
      next if border(grid, xx, yy)
      next if visited.include?([xx, yy])
      queue << [xx, yy]
    end
  end
  visited.to_a
end

puts basins.sort_by { |basin| basin.size }.last(3).reduce(1) { |a, b| a * b.size }
