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

  def test_server_can_receive_request
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert response.success?
  end

  def test_response_with_root_path
    skip
    response = root_response
    assert_equal response, Faraday.get('http://127.0.0.1:9292/').body
  end

  def test_response_with_hello
    skip
    @hello_counter = 1
    response = hello_response
    assert_equal response, Faraday.get('http://127.0.0.1:9292/hello').body
  end

  def test_multiple_responses_with_hello
    skip
    @hello_counter = 7
    response = hello_response
    5.times do
      Faraday.get('http://127.0.0.1:9292/hello')
    end
    assert_equal response, Faraday.get('http://127.0.0.1:9292/hello').body
  end

  def test_response_with_date_time
    response = datetime_response
    assert_equal response, Faraday.get('http://127.0.0.1:9292/datetime').body
  end

  def test_response_with_shutdown
    @visited = 13
    response = shutdown_response
    5.times do
      Faraday.get('http://127.0.0.1:9292/hello')
    end
    assert_equal response, Faraday.get('http://127.0.0.1:9292/shutdown').body
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
    assert_equal "/word_search?word=cat", filtered_path
  end

  def test_it_can_find_a_word_from_the_path
    @request_lines = word_search_request
    assert_equal "word", parameter
    assert_equal "cat", value
  end
end
