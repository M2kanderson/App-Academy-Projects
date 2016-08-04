require_relative 'sudoku_game'
require 'colorize'

class Solver

  def initialize(board)
    @board = board
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

  def fill_pos(pos)
    (1..@board.grid.length).each do |trial_value|
      if(@board.valid?(pos,trial_value))
        @board[pos] = trial_value.to_s
        break
      end
    end
  end

  def solve
    nx = 0
    ny = 0
    pos = [ny,nx]
    while(ny < 9)
      if(@board.grid[pos[0]][pos[1]].value=="0")
        fill_pos(pos)
      else
        while(nx < 9)
          nx+=1
          fill_pos(pos)
          if(nx == 9)
            nx = 1
            ny += 1
            fill_pos(pos)
            if ny == 9
              render
            end
          end
        end
      end
    end

  end

end

board = Board.from_file("puzzles/sudoku1.txt")
solver = Solver.new(board)
solver.solve
