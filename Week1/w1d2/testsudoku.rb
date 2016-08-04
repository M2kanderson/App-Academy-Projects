class SudokuGame
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def play
    until(over?)
      render
      input = prompt
      value = input[0]
      pos = input[1]
      @board[pos] = value
    end
  end

  def render
    p @board

  end

  def prompt

  end

  def over?
    @board.is_full?
  end

end



class Tile
  attr_reader :value, :given
  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def to_s
    @value.colorize(:purple)
  end

end


class Board

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    grid = []
    f = File.readlines(file).map(&:chomp)
    f.each do |row|
      grid << row.split("").map(&:to_i)
    end
    Board.new(grid)
  end

  def get_tile(pos)
    self[pos]
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos,val)
  end

  def is_full?
    @grid.flatten.none? { |value| value == nil}
  end

end




# game = SudokuGame.new(board)

# p game.board.grid
# game.board[[0,0]] = 5
# p game.board.grid

board = Board.from_file("puzzles/sudoku2.txt")
game = SudokuGame.new(board)
game.render
