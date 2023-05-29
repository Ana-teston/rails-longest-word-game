require 'net/http'
class GamesController < ApplicationController

  def new
    @letters = generate_letters(10)
  end

  def score
    word = params[:word]
    Rails.logger.info("Submitted word: #{word}")
    @valid_word = validate_word(word)
    @valid_grid_word = valid_grid_word(word)

    if @valid_word
      Rails.logger.info("The word '#{word}' is valid according to the grid and is an English word.")
    else
      if @valid_grid_word
        Rails.logger.info("The word '#{word}' is valid according to the grid, but is not a valid English word.")
      else
        Rails.logger.info("The word '#{word}' can't be built out of the original grid.")
      end
    end

    render 'score'
  end

  private

  def generate_letters(_number)
    Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def valid_grid_word(word)
    # Implement the logic to check if the word can be built from the original grid
    # Return true if the word is valid according to the grid, false otherwise
    # You need to define this method based on your specific requirements
  end

  def validate_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['found']  # Returns true if the word is found, false otherwise
  end
end
