require_relative "board"
require_relative "pieces"
require_relative "display"


class ChessGame

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
    @current_color = "white"
    @display = Display.new(@board)
  end

  def get_pos
    pos = nil
    until(is_your_piece?(pos))
      loop do
        @display.render
        pos = @display.get_input
        if(pos)
          break
        end
      end
    end
    pos
  end

  def get_end_pos
    pos = nil

    loop do
      @display.render
      pos = @display.get_input
      if(pos)
        break
      end
    end

    pos
  end

  def is_your_piece?(pos)
    if(pos)
      puts "hello"
      return @board[pos].color == @current_color
    else
      return false
    end
  end

  def play_turn
    #select piece

    start_pos = get_pos
    end_pos = get_end_pos
    @board.move(start_pos,end_pos)
    # select move square
    #make move if doesn't put player in check
    #check for check or checkmate
  end

  def checkmate?
    @board.checkmate?(@current_color)
  end

  def play
    until(checkmate?)
      p @current_color
      play_turn
      switch!
    end
  end

  def switch!
    @current_color = @current_color == "black" ? "white" : "black"
  end

end
