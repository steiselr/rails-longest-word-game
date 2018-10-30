class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
    @start_time = Time.now
  end

  def included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  def english?(guess)
    answer = open("https://wagon-dictionary.herokuapp.com/#{guess}")
    result = JSON.parse(answer.read)
    result[found]
  end

  def score
    @word = params[:guess]
    if !@word.included?(:guess, @letters)
      return @result = "Sorry but #{@word.upcase} can't be built out of #{@letters.join("")}"
    elsif !@word.english?(:guess)
      return @result = "Sorry but #{@word.upcase} doesn't seem to be a valid English word..."
    else
      return @result = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end
end
