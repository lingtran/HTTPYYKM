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

  def test_response_with_root_path
    skip
  end

  def test_response_with_hello
    skip

#     <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>
  end
end
