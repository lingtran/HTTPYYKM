require '../lib/server'

class Game
  attr_reader :guesses_made, :guess

  def initialize(request_lines)
    @guesses_made = guesses_made
    @base_number = Random.rand(1..10)
  end

  def evaluate_number(request_lines, client)
    guess = guess_getter(request_lines, client)
    if guess == @base_number
      "You are correct!  Are you psychic?!?"
    elsif
      guess > 10 || guess < 1
      "Please enter a number between 1 and 10"
    elsif guess > @base_number
        "Your guess is too high"
    elsif guess < @base_number
        "Your guess is too low"
    else
      "Keep at it."
    end
  end

  def guess_getter(request_lines, client)
    content_length = request_lines[3].split(": ")
    integer = content_length[1].to_i
    guess = client.read(integer).split("\r\n")[3].to_i
  end

  def guess_stored(guess)
    @guesses_made
  end



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
