input = ARGF.read.lines

# part 1

pos = 0
depth = 0

input.each do |line|
  dir, dist = line.split(" ")
  dist = dist.to_i
  case dir
  when "forward"
    pos += dist
  when "down"
    depth += dist
  when "up"
    depth -= dist
  else
    raise "Unknown direction: #{dir}"
  end
end

puts pos * depth

# part 2

aim = 0
pos = 0
depth = 0

input.each do |line|
  dir, dist = line.split(" ")
  dist = dist.to_i
  case dir
  when "forward"
    pos += dist
    depth += aim * dist
  when "down"
    aim += dist
  when "up"
    aim -= dist
  else
    raise "Unknown direction: #{dir}"
  end
end

puts pos * depth
