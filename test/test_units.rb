require 'faraday'
# require '../lib/client'
require '../lib/server'
require '../lib/filters'
require '../lib/responses'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'request_lines'

class ServerTest < Minitest::Test
  include Responses, Filters, RequestLines

  def setup
    @visited = 0
    @hello_counter = 0
  end

  def test_multiple_responses_with_hello # unit test hello counter
    skip
    @hello_counter = 7
    response = hello_response
    5.times do
      Faraday.get('http://127.0.0.1:9292/hello')
    end
    assert_equal response, Faraday.get('http://127.0.0.1:9292/hello').body
  end

  def test_verifying_shutdown_path
    @request_lines = shutdown_request
    assert_equal "/shutdown", filter_path
  end

  def test_can_filter_verb
    @request_lines = root_request
    assert_equal "GET", filter_verb

    @request_lines = start_game_request
    assert_equal "POST", filter_verb
  end

  def test_can_filter_protocol
    @request_lines = root_request
    assert_equal "HTTP/1.1", filter_protocol
  end

  def test_can_filter_host
    @request_lines = root_request
    assert_equal "127.0.0.1", filter_host
  end

  def test_can_filter_word_search_path
    @request_lines = word_search_request
    assert_equal "/word_search", filter_path
  end

  def test_word_search_parameter_and_value_can_be_parsed
    @request_lines = word_search_request
    assert_equal "word", filter_parameter
    assert_equal "cat", filter_value
  end

  def test_word_search_value_can_be_verified_in_dictionary
    @request_lines = word_search_request
    assert_equal "CAT is a known word", word_value_verification

    @request_lines = word_search_request_2
    assert_equal "PAWSOME is not a known word", word_value_verification
  end

  def test_can_filter_start_game_path
    @request_lines = start_game_request
    assert_equal "/start_game", filter_path
  end
end
