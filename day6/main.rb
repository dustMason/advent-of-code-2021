input = ARGF.read.split(",").map(&:to_i)

def simulate(days, input)
  map = [0] * 9
  input.each { |i| map[i] += 1 }
  days.times do
    new_fish_count = map.shift
    map[8] = new_fish_count
    map[6] += new_fish_count
  end
  map.sum
end

# part 1
puts simulate(80, input)
# part 2
puts simulate(256, input)
