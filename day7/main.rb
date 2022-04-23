input = ARGF.read.split(",").map(&:to_i)

# part 1

def median(array)
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2
end

m = median(input)
distances = input.map { |i| (i - m).abs }
puts distances.sum

# part 2

def average(array)
  (array.reduce(0.0, :+) / array.length).round
end

# 1 + 2 ... + n
def triangular(n)
   (n * (n + 1)) / 2
end

best = Float::INFINITY

# lazy solution: get close and then brute force the rest of the way
[1, -1].each do |side|
  100.times do |t|
    a = average(input)
    distances = input.map { |i| triangular((i - a + (t*side)).abs) }
    if distances.sum < best
      best = distances.sum
      puts best
    end
  end
end