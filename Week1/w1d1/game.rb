require_relative 'Player'
require 'Set'

class GhostGame

  attr_accessor :current_player, :player_one, :player_two, :dictionary, :fragment, :start_dictionary
  def initialize(player_one,player_two,fragment,dictionary)
    @player_one = player_one
    @player_two = player_two
    @fragment = fragment
    @start_dictionary = dictionary.dup
    @dictionary = Set.new(dictionary)
    @current_player = player_one
  end

  def next_player!
    @current_player == player_one ? @current_player = player_two : @current_player = player_one

  end

  def take_turn
#guess letter. if fragment is in dictionary, add strike to player
    guess = current_player.guess
    if(!valid_play?(guess))
      current_player.alert_invalid_guess
      @fragment = start_dictionary.sample[(0..2)]
      @dictionary = Set.new(start_dictionary.dup)
    else
      fragment << guess
      filter!(fragment)
    end

end

  def is_a_letter?(string)
    ("a".."z").to_a.include?(string)
  end

  def is_a_word?(string)
    dictionary.include?(string)
  end

  def filter!(string)
    @dictionary.select! { |word| word.start_with?(string)}
  end

  def can_be_a_word?(string)
    possible_words = dictionary.select { |word| word.start_with?(string)}
    possible_words.length > 0
  end

  def valid_play?(string)
    is_a_letter?(string) && !is_a_word?(fragment + string) && can_be_a_word?(fragment + string )
  end



  def game_over?
    player_one.lose? || player_two.lose? || dictionary.length == 0
  end

  def play
    until(game_over?)
      puts "Fragment: #{fragment}"
      puts "#{current_player.name} has #{current_player.strikes} strikes"
      take_turn
      next_player!
    end
    next_player!
    puts "Game ova Sucka! #{current_player} wins!"
  end

end

player_one = Player.new("Bob")
player_two = Player.new("Paul")
dictionary = File.readlines("ghost-dictionary.txt").map!(&:chomp)

# ("a")

game = GhostGame.new(player_one,player_two,"cal",dictionary)



  game.play
