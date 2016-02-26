require 'minitest/autorun'
require 'minitest/pride'
require_relative 'fake_game_request_lines'
require '../lib/game'
require 'pry'

class GameTest < Minitest::Test
  include FakeGameRequestLines
  def test_a_new_instance_of_Game_can_be_created
    game_1 = Game.new(fake_game_request_lines1)
    assert_equal Game, game_1.class
  end

  def test_it_can_parse_the_guessed_number
    game_1 = Game.new(fake_game_request_lines1)
    assert_equal 20, game_1.guess_getter(fake_game_request_lines1)
  end

  def test_it_can_count_guesses_made
    # skip
      @base_number = 15
    game_1 = Game.new(fake_game_request_lines1)
    first_guess = game_1.guess_getter(fake_game_request_lines1)
      game_1.guess_stored(first_guess)
    second_guess = game_1.guess_getter(fake_game_request_lines2)
      game_1.guess_stored(second_guess)

    assert_equal 2, game_1.guess_count
  end

  def test_it_can_return_guess_number
    # skip
    @base_number = 15
    game_1 = Game.new(fake_game_request_lines1)
    first_guess = game_1.guess_getter(fake_game_request_lines1)
    second_guess = game_1.guess_getter(fake_game_request_lines2)

    assert_equal 20, first_guess
    assert_equal 8, second_guess
  end

  def test_it_can_evaluate_guess_number
    # skip
    try1 = Game.new(fake_game_request_lines1)
    @base_number = 15
    first_guess = try1.guess_getter(fake_game_request_lines1)
    binding.pry
      eval_1 = try1.evaluate_number(first_guess)

    try2 = Game.new(fake_game_request_lines2)
    @base_number = 15
    second_guess = try2.guess_getter(fake_game_request_lines2)
      eval_2 = try2.evaluate_number(second_guess)

    try3 = Game.new(fake_game_request_lines3)
    @base_number = 15
    third_guess = try3.guess_getter(fake_game_request_lines3)
      eval_3 = try3.evaluate_number(third_guess)# guess is "10000"

    try4 = Game.new(fake_game_request_lines4)
    @base_number = 15
      bad_guess = try3.guess_getter(fake_game_request_lines4)
        eval_4 = try3.evaluate_number(bad_guess) # guess is "_"

    assert_equal "Your guess is too high", eval_1
    assert_equal "Your guess is too low", eval_2
    assert_equal "Please enter a number between 1 and 100", eval_3
    assert_equal "Please enter a number between 1 and 100", eval_4
  end
  #
  # def test_it_can_generate_a_number_to_try_to_guess
  #   game_1 = Game.new(fake_game_request_lines1)
  #   game_1.generate_number(number)
  # end

end
