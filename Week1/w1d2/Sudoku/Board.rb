require 'colorize'
class Board

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    grid = []
    f = File.readlines(file).map(&:chomp)
    f.each do |row|
      grid << row.split("").map{|val| Tile.new(val,val != "0")}
    end
    Board.new(grid)
  end

  def valid_box?(pos, guess)
    box = []
    rows = []
    if(pos[0]/3 == 0)
      #first 3 rows
      rows << @grid[0]
      rows << @grid[1]
      rows << @grid[2]
      if(pos[1]/3 == 0)
        #first 3 columns
        box << rows[0][(0..2)]
        box << rows[1][(0..2)]
        box << rows[2][(0..2)]
      elsif(pos[1]/3 == 1)
        #second 3 columns
        box << rows[0][(3..5)]
        box << rows[1][(3..5)]
        box << rows[2][(3..5)]
      else
        #last 3 columns
        box << rows[0][(6..8)]
        box << rows[1][(6..8)]
        box << rows[2][(6..8)]
      end
    elsif(pos[0]/3 == 1)
      #second 3 rows
      rows << @grid[3]
      rows << @grid[4]
      rows << @grid[5]
      if(pos[1]/3 == 0)
        #first 3 columns
        box << rows[0][(0..2)]
        box << rows[1][(0..2)]
        box << rows[2][(0..2)]
      elsif(pos[1]/3 == 1)
        #second 3 columns
        box << rows[0][(3..5)]
        box << rows[1][(3..5)]
        box << rows[2][(3..5)]
      else
        #last 3 columns
        box << rows[0][(6..8)]
        box << rows[1][(6..8)]
        box << rows[2][(6..8)]
      end
    else
      #last 3 rows
      rows << @grid[6]
      rows << @grid[7]
      rows << @grid[8]
      if(pos[1]/3 == 0)
        #first 3 columns
        box << rows[0][(0..2)]
        box << rows[1][(0..2)]
        box << rows[2][(0..2)]
      elsif(pos[1]/3 == 1)
        #second 3 columns
        box << rows[0][(3..5)]
        box << rows[1][(3..5)]
        box << rows[2][(3..5)]
      else
        #last 3 columns
        box << rows[0][(6..8)]
        box << rows[1][(6..8)]
        box << rows[2][(6..8)]
      end
    end
    !includes_tile?(box.flatten,guess)
  end

  def valid_row?(pos, guess)
    !includes_tile?(@grid[pos[0]], guess)
  end

  def valid_col?(pos,guess)
    column = []
    @grid.each do |row|
      column << row[pos[1]]
    end
    !includes_tile?(column, guess)
  end

  def includes_tile?(array, guess)
    array.any? do |el|
      el.value == guess
    end
  end

  def valid?(pos,guess)
    !@grid[pos[0]][pos[1]].given && valid_row?(pos,guess) && valid_col?(pos,guess) && valid_box?(pos,guess)
  end

  def get_tile(pos)
    self[pos]
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos,val)
    self[pos].value = val
  end

  def is_full?
    @grid.flatten.none? { |tile| tile.value == "0"}
  end

end

# grid = [[1,2,3],[4,nil,6],[7,8,9]]
# board = Board.new(grid)
# p board.is_full?
