nums = ARGF.read.lines.map(&:to_i)

def sum_cons nums
  count = 0
  nums.each_cons(2) { |one, two| count += 1 if two > one }
  count
end

# part 1
puts sum_cons(nums)

# part 2
windows = nums.each_cons(3).map { |a, b, c| a + b + c }
puts sum_cons(windows)

