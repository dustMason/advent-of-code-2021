edges = Hash.new { |h, k| h[k] = [] }
ARGF.read.lines.each do |line|
  left, right = line.chomp.split("-")
  edges[left] << right
  edges[right] << left
end

# find all possible paths from edges["start"] to edges["end"]
def find_paths(edges, start, end_node, path = [], &block)
  path << start
  return [path] if start == end_node
  paths = []
  edges[start].each do |node|
    next unless yield(path, node)
    paths += find_paths(edges, node, end_node, path.dup, &block)
  end
  paths
end


# part 1
paths = find_paths(edges, "start", "end") { |path, node| !path.include?(node) || !(node.downcase == node) }
puts paths.size

# part 2
def can_visit(path, node)
  return false if node == "start"
  return true if !(node.downcase == node)
  return true if !path.include?(node)
  return true if path.select { |n| n.downcase == n }.tally.values.max == 1
  false
end
paths = find_paths(edges, "start", "end") { |path, node| can_visit(path, node) }
puts paths.size
