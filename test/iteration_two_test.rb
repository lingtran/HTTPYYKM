require 'faraday'
require '../lib/iteration_two_client'
require '../lib/iteration_two_server'
require 'minitest/autorun'
require 'minitest/pride'


class ServerTest < Minitest::Test

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

end
