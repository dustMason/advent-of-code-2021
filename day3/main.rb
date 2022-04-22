input = ARGF.read.lines
digits = input[0].chomp.size
nums = input.map { |line| line.to_i(base=2) }

# part 1

gamma = 0
epsilon = 0
digits.times.reverse_each do |p|
  mask = 1 << p
  if nums.count { |num| num & mask > 0 } > nums.count / 2
    gamma += mask
  else
    epsilon += mask
  end
end

puts gamma * epsilon

# part 2

def get_rating(nums, digits, bias)
  candidates = nums
  rating = 0
  digits.times.reverse_each do |p|
    mask = 1 << p
    bit = true
    if candidates.count { |num| num & mask > 0 } < candidates.count / 2.0
      bit = false
    end

    bit = !bit if !bias

    candidates = candidates.select { |num| (num & mask > 0) == bit }
    if candidates.size == 1
      rating = candidates.first
      break
    end
  end
  rating
end

o2_rating = get_rating(nums, digits, true)
co2_rating = get_rating(nums, digits, false)
puts co2_rating * o2_rating
