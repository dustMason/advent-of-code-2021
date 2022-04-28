points = []
folds = [] # array of [axis, dist]
input = ARGF.read.lines
input.each do |line|
  next if line.chomp.empty?
  if line.start_with?('fold')
    axis, dist = line.delete_prefix("fold along ").split('=')
    folds << [axis, dist.to_i]
  else
    points << line.split(',').map(&:to_i)
  end
end

def fold(points, axis, dist)
  points.map do |p|
    p[0] += (dist - p[0]) * 2 if p[0] >= dist && axis == "x"
    p[1] += (dist - p[1]) * 2 if p[1] >= dist && axis == "y"
    p
  end
end

def print_points(points)
  grid = Array.new(points.max_by { |p| p[1] }[1] + 1) { Array.new(points.max_by { |p| p[0] }[0] + 1, ".") }
  points.each { |p| grid[p[1]][p[0]] = "#" }
  grid.each { |row| puts row.join }
end

# part 1
puts fold(points, folds[0][0], folds[0][1]).uniq.size

# part 2
points = fold(points, *folds.shift) until folds.empty?
print_points(points)