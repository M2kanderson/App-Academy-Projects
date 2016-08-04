require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value
  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def to_s
    @value.colorize(:blue)
  end

end
