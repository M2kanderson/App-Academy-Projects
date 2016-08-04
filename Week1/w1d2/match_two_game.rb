
class Game
  def initialize(board, player = ComputerPlayer.new("Jeff"))
    @player = player
    @previous_guess = nil
    @board = board
  end

  def play
    @board.populate
    until(over?)
      invalid = true
      while invalid
        render
        pos = @player.prompt(@board.grid.size)
        invalid = invalid?(pos)
      end

      # @player.set_val(pos, @board[*pos])
      make_guess(pos)
    end
  end

  def over?
    @board.grid.flatten.all? do |card|
      card.revealed?
    end
  end

  def render
    @board.render
  end

  def invalid?(input)
    p input
    @board[*input].revealed?
  end

  def make_guess(pos)
    if(@previous_guess == nil)
      @previous_guess = pos
      @board[*pos].reveal
      @player.receive_revealed_card(pos,@board[*pos].face_value)
    else
      if(@board[*pos] == @board[*@previous_guess])
        puts "You got it!"
        @board[*pos].reveal
        @player.receive_revealed_card(pos,@board[*pos].face_value)
        @player.receive_match(pos,@previous_guess)
      else
        puts "You were wrong!"
        @board[*pos].reveal
        @player.receive_revealed_card(pos,@board[*pos].face_value)
        @board.render
        sleep(2)
        system("clear")
        @board[*pos].hide
        @board[*@previous_guess].hide
      end
      @previous_guess = nil
    end
  end
end

class ComputerPlayer
  attr_reader :found_numbers
  def initialize(name = "Hal")
    @name = name
    @found_numbers = []
    @matched_cards = []
    @known_card = Hash.new([])
    @positions = []
  end

  def receive_revealed_card(pos,value)
    @known_card[value] += [pos] if(@known_card[value] != pos && @known_card[value].length < 2)
  end

  def receive_match(pos1,pos2)
    @matched_cards<<pos1
    @matched_cards<<pos2
  end

  def matched_card?(pos)
    @matched_cards.include?(pos)
  end

  def prompt(size)
    matched = @known_card.select do |k,v|
      v.length > 1
    end


    unless matched.empty?
      @positions = matched[matched.keys.first]
    end

    unless @positions.empty?
      pos = @positions.shift
    else
      pos = [rand(size),rand(size)]
      while matched_card?(pos)
        pos = [rand(size),rand(size)]
      end
    end
    pos
  end
  #
  # def set_val(pos, val)
  #   @found_numbers[pos] = val
  # end

  # def found_two_numbers
  #   @found_numbers.select do |key, val|
  #     @found_numbers.values.count(val) > 1
  #   end
  # end
  #
  # def pos_already_found(pos)
  #   @found_numbers.has_key?(pos)
  # end

  def pos_already_found(pos)
    @found_numbers.include?(pos)
  end



end

class HumanPlayer
  def initialize(name)
    @name = name
  end

  def receive_revealed_card(pos,val)

  end

  def receive_match(pos1,pos2)

  end

  def prompt(size = nil)
    puts "Make a guess!"
    gets.chomp.split(",").map(&:to_i)
  end
end


class Board
  attr_reader :grid
  def initialize(grid)
    @grid = grid
  end

  def filled?
    @grid.flatten.none? do |el|
      el.is_a?(NilClass)
    end
  end

  def possible_cards
    card_values = []
    (1..grid.length**2/2).to_a.each do |card_value|
      card_values << card_value
      card_values << card_value
    end
    card_values
  end

  def populate
    poss_cards = possible_cards()
    until(filled?)
      @grid.each_with_index do |row, y|
        row.each_with_index do |col, x|
          card_value = poss_cards.sample
          poss_cards.delete_at(poss_cards.index(card_value))
          card = Card.new(card_value)
          @grid[x][y] = card
        end
      end
    end
  end

  def render
    @grid.each do |row|
      row.each  do |card|
        print "|"
        if card.face_side == :up
          print card.face_value
        else
          print "x"
        end
        print "|"
      end
      puts
      @grid.length.times {print "---"}
      puts
    end
  end

  def won?

  end

  def reveal(pos)
    @grid[pos].reveal
  end

  def [](*pos)
    @grid[pos[0]][pos[1]]
  end

end

class Card
  attr_reader :face_value, :face_side
  def initialize(face_value, face_side = :down)
    @face_value = face_value
    @face_side = face_side
  end

  def self.dup
    Card.new(self.face_value)
  end

  def hide
    @face_side = :down
  end

  def revealed?
    @face_side == :up
  end

  def reveal
    @face_side = :up
  end

  def to_s
    @face_value.to_s
  end

  def ==(card)
    self.face_value == card.face_value
  end

end

grid = Array.new(4){Array.new(4)}
board = Board.new(grid)
player = HumanPlayer.new("Bob")
game = Game.new(board, player)
game.play
# board.populate
# (0..3).to_a.each_with_index do |row, row_index|
#   (0..3).to_a.each_with_index do |col, col_index|
#     board[col_index,row_index].reveal
#   end
# end
# board.render
