require 'faraday'
# require '../lib/client'
require '../lib/server'
require '../lib/responses'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'request_lines'
class ServerTest < Minitest::Test
  include Responses, RequestLines

  def setup
    @visited = 0
    @hello_counter = 0
  end

  def test_server_can_receive_request_for_root
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert response.success?
  end

  def test_server_can_receive_request_for_hello
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert response.success?
  end

  def test_server_can_receive_request_datetime
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    assert response.success?
  end

  def test_server_can_receive_request_word_search
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=cat'
    assert response.success?
  end

  def test_response_with_root_path
    response = "Path: /"
    assert Faraday.get('http://127.0.0.1:9292/').body.include?(response)
  end

  def test_response_with_hello
    response_1 = "Hello, World!"
    response_2 = "Path: /hello"
    assert Faraday.get('http://127.0.0.1:9292/hello').body.include?(response_1)
    assert Faraday.get('http://127.0.0.1:9292/hello').body.include?(response_2)

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

  def test_response_with_date_time
    response = "Path: /datetime"
    assert Faraday.get('http://127.0.0.1:9292/datetime').body.include?(response)
  end

  def test_response_with_shutdown
    skip #make new file for testing shutdown
    response = "Total Requests:"
    assert Faraday.get('http://127.0.0.1:9292/shutdown').body.include?(response)
  end

  def test_verifying_shutdown_path
    @request_lines = shutdown_request
    assert_equal "/shutdown", filtered_path
  end

  def test_response_diagnostics_can_be_dynamically_parsed
    @request_lines = root_request
    assert_equal "GET", filtered_verb
  end

  def test_response_diagnostics_can_be_dynamically_parsed
    @request_lines = root_request
    assert_equal "HTTP/1.1", filtered_protocal
  end

  def test_response_diagnostics_can_be_dynamically_parsed
    @request_lines = root_request
    assert_equal "127.0.0.1", filtered_host
  end

  def test_response_with_single_word_search
    @request_lines = word_search_request
    assert_equal "/word_search", filtered_path
  end

  def test_word_search_parameter_and_value_can_be_parsed
    @request_lines = word_search_request
    assert_equal "word", parsed_param
    assert_equal "cat", parsed_value
  end

  def test_word_search_value_can_be_verified_in_dictionary
    @request_lines = word_search_request
    assert_equal "CAT is a known word", word_value_verification

    @request_lines = word_search_request_2
    assert_equal "PAWSOME is not a known word", word_value_verification
  end

end
