require '../lib/server'

class Game
  attr_reader :guess
  def initialize(request_lines)
    @guess = guess_getter(request_lines)
    @guesses_made = []
    @base_number = 15
    # Random.rand(1..100)
    # @guidance = guide_user
  end

  def evaluate_number(guess)
    right_number = @base_number
    if @guess == right_number
      "You are correct!  Are you psychic?!?"
    elsif
      @guess > 100 || @guess < 0
      "Please enter a number between 1 and 100"
    elsif @guess < 100 && @guess > 0
        if @guess > right_number
          "Your guess is too high"
        elsif @guess < right_number
          "Your guess is too low"
        end
    end
  end

  # def generate_number(number = nil)
  #   Random.rand(1..100)
  # end

  def guess_getter(request_lines)
    request_lines.fetch(17).to_i
  end

  def guess_stored(guess)
    @guesses_made << @guess
  end

  def guess_count
    @guesses_made.count
  end
end
#
# if __FILE__ == $0
#
# game_1 = Game.new
# game_1.guess
#
# end
