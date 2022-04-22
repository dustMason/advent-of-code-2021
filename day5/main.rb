input = ARGF.read
lines = input.lines.map do |line|
  line.split(" -> ").map { |pair| pair.split(",").map(&:to_i) }
end

def plot(lines, diagonals = false)
  grid = Hash.new(0)
  lines.each do |from, to|
    next if !diagonals && from[0] != to[0] && from[1] != to[1]
    x, y = from
    xm = (to[0] - from[0]) <=> 0
    ym = (to[1] - from[1]) <=> 0
    while x != to[0] || y != to[1]
      grid[[x,y]] += 1
      x += xm
      y += ym
    end
    grid[[x,y]] += 1
  end
  grid
end


# part 1
puts plot(lines).count { |_, v| v > 1 }

# part 2
puts plot(lines, true).count { |_, v| v > 1 }
