require 'colorize'
require_relative 'cursorable'
require_relative 'board'

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0,0]
  end

  def build_grid
    @board.grid.map.with_index do |row, row_index|
      build_row(row,row_index)
    end
  end

  def build_row(row,row_index)
    row.map.with_index do |piece, col_index|
      #get colors for piece based on piece location and cursor location
      color_options = colors_for(row_index,col_index)
      #color the piece
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
    nil
  end

  def render_board
    while(true)
      render
      get_input
    end
  end
end

#
# b = Board.new()
# display = Display.new(b)
# display.render_board
