input = ARGF.read.chomp

delimiters = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
delimiters_inv = delimiters.invert

def median(array)
  sorted = array.sort
  (sorted[(sorted.size - 1) / 2] + sorted[sorted.size / 2]) / 2
end


invalid_points = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
incomplete_points = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }

invalid_score = 0
incomplete_scores = []
input.lines.each do |line|
  stack = []
  s = 0
  line.chars.each do |char|
    if delimiters.include?(char)
      stack.push(char)
    elsif delimiters_inv.include?(char)
      if char == delimiters[stack.last]
        stack.pop
      else
        s += invalid_points[char]
        break
      end
    end
  end
  invalid_score += s
  if s == 0
    incomplete_score = 0
    until stack.empty?
      closer = delimiters[stack.pop]
      incomplete_score = (incomplete_score * 5) + incomplete_points[closer]
    end
    incomplete_scores << incomplete_score
  end
end

puts invalid_score # part 1
puts median(incomplete_scores) # part 2
