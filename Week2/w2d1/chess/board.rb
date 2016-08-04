require_relative 'pieces'
require 'byebug'

class Board

  attr_reader :grid

  def initialize(grid = new_board)
    @grid = grid
  end

  def in_check_board
    pieces = Array.new(8){Array.new(8)}
    null_piece = NullPiece.instance
    pieces.each_with_index do |row, row_index|
      row.each_index do |col_index|
        pieces[row_index][col_index] = null_piece
      end
    end
    # pieces[0][0] = Rook.new("black",[0,0],self)
    # pieces[0][7] = Rook.new("black",[0,7],self)
    # pieces[0][1] = Knight.new("black",[0,1],self)
    # pieces[0][6] = Knight.new("black",[0,6],self)
    # pieces[0][2] = Bishop.new("black",[0,2],self)
    # pieces[0][5] = Bishop.new("black",[0,5],self)
    pieces[5][7] = Queen.new("black",[5,7],self)
    pieces[6][5] = King.new("black",[6,5],self)
    # pieces[1].each_with_index do |piece, index|
    #   pieces[1][index] = Pawn.new("black",[1,index],self)
    # end

    # pieces[7][0] = Rook.new("white",[7,0],self)
    # pieces[7][7] = Rook.new("white",[7,7],self)
    # pieces[7][1] = Knight.new("white",[7,1],self)
    # pieces[7][6] = Knight.new("white",[7,6],self)
    # pieces[7][2] = Bishop.new("white",[7,2],self)
    # pieces[7][5] = Bishop.new("white",[7,5],self)
    # pieces[7][3] = Queen.new("white",[7,4],self)
    pieces[7][7] = King.new("white",[7,7],self)
    # pieces[6].each_with_index do |piece, index|
    #   pieces[6][index] = Pawn.new("white",[6,index],self)
    # end
    pieces
  end

  def new_board
    pieces = Array.new(8){Array.new(8)}
    null_piece = NullPiece.instance
    pieces.each_with_index do |row, row_index|
      row.each_index do |col_index|
        pieces[row_index][col_index] = null_piece
      end
    end
    pieces[0][0] = Rook.new("black",[0,0],self)
    pieces[0][7] = Rook.new("black",[0,7],self)
    pieces[0][1] = Knight.new("black",[0,1],self)
    pieces[0][6] = Knight.new("black",[0,6],self)
    pieces[0][2] = Bishop.new("black",[0,2],self)
    pieces[0][5] = Bishop.new("black",[0,5],self)
    pieces[0][3] = Queen.new("black",[0,3],self)
    pieces[0][4] = King.new("black",[0,4],self)
    pieces[1].each_with_index do |piece, index|
      pieces[1][index] = Pawn.new("black",[1,index],self)
    end

    pieces[7][0] = Rook.new("white",[7,0],self)
    pieces[7][7] = Rook.new("white",[7,7],self)
    pieces[7][1] = Knight.new("white",[7,1],self)
    pieces[7][6] = Knight.new("white",[7,6],self)
    pieces[7][2] = Bishop.new("white",[7,2],self)
    pieces[7][5] = Bishop.new("white",[7,5],self)
    pieces[7][3] = Queen.new("white",[7,3],self)
    pieces[7][4] = King.new("white",[7,4],self)
    pieces[6].each_with_index do |piece, index|
      pieces[6][index] = Pawn.new("white",[6,index],self)
    end
    pieces
  end

  def locate_king(color)
    grid.flatten.select do |piece|
      piece.is_a?(King) && piece.color == color
    end.first.position
  end



  def in_check?(color)
    king_pos = locate_king(color)
    grid.flatten.any? do |piece|
      piece.moves.include?(king_pos) if piece.color != color
    end
  end

  def move(start_pos, end_pos)
    if self[start_pos].moves.include?(end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].position = end_pos
      self[start_pos] = NullPiece.instance
    end
  end


    #check valid moves for that piece

    #if valid, make move



  def checkmate?(color)
    #debugger
    #k_x,k_y = locate_king(color)
    grid.flatten.each do |piece|
      if piece.is_a?(Piece) && piece.color == color
        start_pos = piece.position
        piece.moves.each do |end_pos|
          dup_board = self.dup
          dup_board.move(start_pos,end_pos)#perform move on dupped board and check if in check

          return false unless(dup_board.in_check?(color))
        end
      end
    end
    true
  end









  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def in_bounds?(pos)
    x, y = pos
    in_bounds = x.between?(0,7) && y.between?(0,7)
    in_bounds

  end

  def dup
    new_board = Board.new
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if piece.is_a?(Piece)
          color = piece.color
          type = piece.class
          new_board[[row_idx, col_idx]] = type.new(color, [row_idx, col_idx], new_board)
        else
          new_board[[row_idx, col_idx]] = NullPiece.instance
        end
      end
    end
    new_board
  end
end
