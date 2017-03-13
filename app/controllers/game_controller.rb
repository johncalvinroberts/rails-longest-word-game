class GameController < ApplicationController
  def guess
    @grid = generate_grid(8)
  end

  def result
    @answer = params[:answer].upcase
    @given_grid = params[:given_grid]
    @start_time = Time.now
    @end_time = params[:end_time].to_time
    @result = run_game(@answer, @given_grid, @start_time, @end_time)
  end


  def generate_grid(grid_size)
    grid = []
    grid_size.times do
      grid << ('A'..'Z').to_a.sample(1)
    end
    grid
  end
end

def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result
  result = {}

  if !anagram?(attempt, grid)
    message = "not in the grid"
    translation = translation(attempt)
    score = 0
  elsif translation(attempt) == attempt
    translation = nil
    message = "not an english word"
    score = 0
  else
  message = "well done"
  translation = translation(attempt)
  score = ((attempt.length.to_f) / (1 + ((end_time - start_time) / 60 )))
  end
result[:time] = (start_time - end_time)
result[:translation] = translation
result[:score] = score
result[:message] = message
return result
end


def translation (word)
  url = "https://api-platform.systran.net/translation/text/translate?source=en&target=fr&key=37a7db77-2c08-49b5-8ad9-a5741d39c6bb
&input=#{word}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  return JSON.parse(response)["outputs"][0]["output"]
end


def anagram? (attempt, grid)
  attempt.split("").all? { |letter| attempt.count(letter) <= grid.count(letter) }
end
