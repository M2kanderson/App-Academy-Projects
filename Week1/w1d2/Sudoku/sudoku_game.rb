require_relative "Board"
require_relative "tile"
require "colorize"


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
      if(@board.valid?(pos,value))
        @board[pos] = value
      else
        puts "invalid move"
      end
    end
    puts "You win!"
  end

  def render
    @board.grid.each_with_index do |row,row_index|
      row.each_with_index do |val, index|
        if(index % 3 == 0)
          print "|"
        else
          print " "
        end
        if val.value == "0"
          print "* "
        else
          if(val.given == true)
            value = val.value.colorize(:blue)
            print "#{value} "
          else
            print "#{val} "
          end
        end
      end
      puts
      if(row_index % 3 == 2)
        print "----------------------------"
        puts
      end

    end
  end

  def prompt
    puts "What's your guess?: "
    value = gets.chomp
    puts "Where would you like it?: "
    pos = gets.chomp.split(",").map(&:to_i)
    [value,pos]
  end

  def over?
    @board.is_full?
  end

end

# 
# board = Board.from_file("puzzles/sudoku1.txt")
# game = SudokuGame.new(board)
# game.play
