require 'faraday'
# require '../lib/client'
require '../lib/server'
require '../lib/filters_responses'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'request_lines'

class ServerTest < Minitest::Test
  include Responses, Filters, RequestLines

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

  def test_response_with_date_time
    response = "Path: /datetime"
    assert Faraday.get('http://127.0.0.1:9292/datetime').body.include?(response)
  end

  def test_response_with_shutdown
    skip #make new file for testing shutdown
    response = "Total Requests:"
    assert Faraday.get('http://127.0.0.1:9292/shutdown').body.include?(response)
  end
end
