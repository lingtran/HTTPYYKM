require 'faraday'
# require '../lib/client'
require '../lib/server'
require '../lib/responses'
require 'minitest/autorun'
require 'minitest/pride'

class ServerTest < Minitest::Test
  include Responses
  def setup
    @visited = 0
    @hello_counter = 0
  end

  def test_server_can_receive_request
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert response.success?
  end

  def test_it_can_send_a_response
    skip
  end

  def test_it_can_prep_a_response
    skip
  end

  def test_response_with_root_path
    response = root_response
    assert_equal root_response, Faraday.get('http://127.0.0.1:9292/').body
  end

  def test_response_with_hello
    @hello_counter = 1
    response = hello_response
    assert_equal hello_response, Faraday.get('http://127.0.0.1:9292/hello').body
  end

  def test_multiple_responses_with_hello
    @hello_counter = 7
    response = hello_response
    5.times do
      Faraday.get('http://127.0.0.1:9292/hello')
    end
    assert_equal response, Faraday.get('http://127.0.0.1:9292/hello').body
  end

  def test_response_with_date_time
    response = datetime_response
    assert_equal datetime_response, Faraday.get('http://127.0.0.1:9292/datetime').body
  end

  def test_response_with_shutdown
    @visited = 13
    response = shutdown_response
    5.times do
      Faraday.get('http://127.0.0.1:9292/hello')
    end
    assert_equal response, Faraday.get('http://127.0.0.1:9292/shutdown').body
  end

  def test_response_diagnostics_can_be_dynamically_parsed
    skip
    response = root_response
    assert_equal response, Faraday.get('http://127.0.0.1:9292/shutdown').body
  end


end
