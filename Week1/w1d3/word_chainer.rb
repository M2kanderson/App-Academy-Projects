require 'set'

class WordChainer
  attr_accessor :dictionary, :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name) { |line| line }.map(&:chomp))
    @current_words = []
    @all_seen_words = Hash.new(nil)
  end

  def adjacent_word?(word1, word2)
    not_matching = 0
    if(word1.length == word2.length)
      word1.chars.each_with_index do |letter, index|
        if(letter != word2[index])
          not_matching += 1
        end
      end
    end
    not_matching == 1
  end

  def adjacent_words(word)
    @dictionary.select do |w|
      adjacent_word?(w,word)
    end
  end

  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil
    until current_words.empty?

      explore_current_words(target)

    end
    build_path(target)
  end

  def build_path(target)
    path = [target]
    until @all_seen_words[target] == nil
      path << @all_seen_words[target]
      target = path.last
    end
    return path
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        next if @all_seen_words.keys.include?(adj_word)
        @all_seen_words[adj_word] = current_word
        new_current_words << adj_word
        if @all_seen_words.include?(target)
          @current_words = new_current_words
          return @current_words
        end
      end
    end
    # new_current_words.each do |word|
    #   puts "#{word},#{@all_seen_words[word]}"
    # end
    @current_words = new_current_words
  end

end


chainer = WordChainer.new('dictionary.txt')

p chainer.run("duck","ruby")
