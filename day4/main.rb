require "set"

input = ARGF.read.lines
picks = input.shift.split(',').map(&:to_i)

class Board
  attr_accessor :tiles
  def initialize(tiles)
    @tiles = tiles
    @hits = [0] * tiles.size # array of numbers, one per row. number has a bit on for each column that has been hit
  end

  def pick(num)
    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        @hits[y] |= 1 << x if tile == num
      end
    end
  end

  def sum_of_unpicked_tiles
    hit_tiles = @hits.map { |hit| hit.to_s(2).rjust(5, "0").reverse }
    sum = 0
    @tiles.each_with_index do |row, y|
      row.each_with_index do |tile, x|
        sum += tile if hit_tiles[y][x] == '0'
      end
    end
    sum
  end

  def winner
    # check rows
    win = @hits.any? { |row| row == 0b11111 }
    return win if win
    # check columns
    5.times do |n|
      win ||= @hits.all? { |row| row & (1 << n) == (1 << n) }
    end
    win
  end
end

boards = input.each_slice(6).map do |board|
  tiles = board[1..].map { |line| line.split(' ').map(&:to_i) }
  Board.new(tiles)
end

winners = Set.new # indexes of winning boards
picks.each do |pick|
  boards.each_with_index do |board, i|
    next if winners.include?(i)
    board.pick(pick)
    if board.winner
      winners.add(i)

      # part 1
      puts board.sum_of_unpicked_tiles * pick if winners.size == 1

      # part 2
      if winners.size == boards.size
        puts board.sum_of_unpicked_tiles * pick
        exit
      end
    end
  end
end
