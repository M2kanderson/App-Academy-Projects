class Player
  attr_accessor :strikes
  attr_reader :name
  def initialize(name)
    @name = name
    @strikes = 0
  end

  def guess
    puts "Guess a letter: "
    guess = gets.chomp

  end

  def alert_invalid_guess
      @strikes += 1
      puts "Not a valid guess"

  end

  def lose?
    strikes == 5
  end

end
