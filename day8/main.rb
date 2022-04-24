input = ARGF.read

# part 1

# map of number of segments to number displayed
unique_digits = { 2 => 1, 4 => 4, 3 => 7, 7 => 8 }

count = 0
input.lines.each do |line|
  _, signal = line.split(" | ")
  signal.split(" ").each do |chunk|
    count += 1 if unique_digits[chunk.size]
  end
end
puts count

# part 2

sum = 0
input.lines.each do |line|
  intro, signal = line.split(" | ")
  intro = intro.split(" ").map { |c| c.chars.sort }
  fives = intro.select { |c| c.size == 5 }
  sixes = intro.select { |c| c.size == 6 }

  one = intro.find { |c| c.size == 2 }
  four = intro.find { |c| c.size == 4 }
  seven = intro.find { |c| c.size == 3 }
  eight = intro.find { |c| c.size == 7 }
  three = fives.find { |c| (c & one) == one }
  nine = sixes.find { |c| (c & four) == four }
  zero, six = (sixes - [nine]).partition { |c| (c & one) == one }.map(&:first)
  five, two = (fives - [three]).partition { |c| (c & six) == c }.map(&:first)

  map = {
    zero => "0",
    one => "1",
    two => "2",
    three => "3",
    four => "4",
    five => "5",
    six => "6",
    seven => "7",
    eight => "8",
    nine => "9",
  }

  sum += signal.split(" ").map { |chunk| map[chunk.split("").sort] }.join.to_i
end
puts sum

