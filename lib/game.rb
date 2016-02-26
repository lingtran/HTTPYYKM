require '../lib/server'

class Game < Server

  def initialize(guess_input)
    @base_number = Random.rand(1..10)
    @guess_input = guess_input
  end

  def evaluate_number(guess_input)
    if @guess_input == @base_number
      "You are correct!  Are you psychic?!?"
    elsif @guess_input > 10 || @guess_input < 1
      "Please enter a number between 1 and 10"
    elsif @guess_input > @base_number
      "Your guess is too high"
    elsif @guess_input < @base_number
      "Your guess is too low"
    else
      "Keep at it."
    end
  end


  # def guess_stored(guess)
  #   @guesses_made
  # end

# want to bring back an array that stores numbers and shuffle number to a fixed index that can be retrieved in Server
# potential reason for number in GET differing from POST -- request line come in differently, so they impact conversion integrity of Server::Responses#guess_input
# array should mitigate aspect of the issue


  # def guess_count
  #   @guesses_made.count
  # end
end
#
# if __FILE__ == $0
#
# game_1 = Game.new
# game_1.guess
#
# end
