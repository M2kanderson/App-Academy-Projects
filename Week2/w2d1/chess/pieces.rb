require 'singleton'
require_relative 'board'
require 'colorize'

DIAGONALS = [[1,1],[1,-1],[-1,-1],[-1,1]]
STRAIGHT = [[0,1],[1,0],[0,-1],[-1,0]]
KNIGHT_MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

class Piece

  attr_reader :color
  attr_accessor :position

  def initialize(color = "white", position, board)
    @color = color
    @position = position
    @board = board
  end

  def valid_move?(pos)
    in_bounds = @board.in_bounds?(pos)
    if(in_bounds)
      not_our_piece = @board[pos].is_a?(Piece) && @board[pos].color != color
      null_piece = @board[pos].is_a?(NullPiece)
      return (not_our_piece || null_piece)
    end
    false
  end

  def moves

  end

  def to_s
    if self.is_a?(NullPiece)
      string = "   "
    elsif @color == "white"
      if @type == "King"
        string = " \u2654 ".colorize(:white)
      elsif @type == "Queen"
        string = " \u2655 ".colorize(:white)
      elsif @type == "Rook"
        string = " \u2656 ".colorize(:white)
      elsif @type == "Bishop"
        string = " \u2657 ".colorize(:white)
      elsif @type == "Knight"
        string = " \u2658 ".colorize(:white)
      else
        string = " \u2659 ".colorize(:white)
      end
    elsif @color == "black"
      if @type == "King"
        string = " \u265A ".colorize(:black)
      elsif @type == "Queen"
        string = " \u265B ".colorize(:black)
      elsif @type == "Rook"
        string = " \u265C ".colorize(:black)
      elsif @type == "Bishop"
        string = " \u265D ".colorize(:black)
      elsif @type == "Knight"
        string = " \u265E ".colorize(:black)
      else
        string = " \u265F ".colorize(:black)
      end
    end
  end

end

class SlidingPiece < Piece
  def moves
    new_positions = []


    move_dirs.each do |move_dir|
      curr_x, curr_y = @position #Set initial position
      loop do
        new_pos = [curr_x+move_dir[0],curr_y+move_dir[1]]
        if valid_move?(new_pos)

          new_positions << new_pos
          unless @board[new_pos].color == color || @board[new_pos].is_a?(NullPiece)
            break
          end
        else
          break
        end
        curr_x, curr_y = new_pos
      end

    end
    new_positions
  end

end

class SteppingPiece < Piece

  def moves
    new_positions = []

    curr_x, curr_y = @position
    move_dirs.each do |move_dir|
      new_pos = [curr_x+move_dir[0],curr_y+move_dir[1]]
      if valid_move?(new_pos)

        new_positions << new_pos
      end
    end
    new_positions
  end
end

class NullPiece
  include Singleton
  def color
    "Rainbow Sparkle"
  end

  def moves
    []
  end

  def to_s
    "   "
  end

end

class Queen < SlidingPiece

  def initialize(color,position,board)
    @type = "Queen"
    super(color,position,board)
  end

  def move_dirs
    STRAIGHT + DIAGONALS
  end

end

class King < SteppingPiece

  def initialize(color,position,board)
    @type = "King"
    super(color,position,board)



  end

  def move_dirs
    STRAIGHT + DIAGONALS
  end

end


class Bishop < SlidingPiece

  def initialize(color,position, board)
    @type = "Bishop"
    super(color,position, board)
    #bishop
    #first, check for valid slope
    #check for intervening pieces
    #make sure it doesn't overindex
  end

  def move_dirs
    DIAGONALS
  end

end

class Knight < SteppingPiece

  def initialize(color,position,board)
    @type = "Knight"
    super(color,position,board)

  end
  def move_dirs
    KNIGHT_MOVES
  end

end

class Rook < SlidingPiece
  def initialize(color,position,board)
    @type = "Rook"
    super(color,position,board)

  end
  def move_dirs
    STRAIGHT
  end

end

class Pawn < SteppingPiece
  def initialize(color,position,board)
    @type = "Pawn"
    super(color,position,board)

  end
  def move_dirs
    x, y = position
    #check diagonals
    if(@color == "black")
      dirs = [[x+1,y]]
      if(x == 1)
        dirs << [x+2,y]
      elsif(@board[x+1,y+1].color == "white")
        dirs << [x+1,y+1]
      elsif(@board[x+1,y-1].color == "white")
        dirs << [x+1,y-1]
      end
    else
      dirs = [[x-1,y]]
      if(x == 6)
        dirs << [x-2,y]
      elsif(@board[x-1,y-1].color == "black")
        dirs << [x-1,y-1]
      elsif(@board[x-1,y+1].color == "black")
        dirs << [x-1,y+1]
      end
    end
    p dirs
    dirs
  end

end
