class HangpersonGame
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  #def initialize()
  #end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses= ""
  end
  
    def check_win_or_lose
    if @word.squeeze.chars.sort.join == @guesses.chars.sort.join
      return :win
    elsif @wrong_guesses.length > 6
      return :lose
    else 
      return :play
    end
  end
  
  def guess(chc)
    if chc==nil
      raise ArgumentError
    elsif chc==""
      raise ArgumentError
    elsif chc =~ /[^a-zA-Z]/
      raise ArgumentError
    else
      chc.downcase!
      if (@guesses.include? chc) || (@wrong_guesses.include? chc)
        return false
      elsif @word.include? chc
        @guesses += chc
      else
        @wrong_guesses += chc
      end
    end
  end
  
  def word_with_guesses
    displayed=""
    for i in 0...@word.length
      if @guesses.include? @word[i] 
        displayed[i]=@word[i]
      else 
        displayed[i]="-"
      end
    end
    puts "#{@word_with_guesses}"
    puts "#{check_win_or_lose}"
    return displayed
  end
  
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
