require 'faraday'
require '../lib/iteration_two'
require 'minitest/autorun'
require 'minitest/pride'

class IterationTwoTest < Minitest::TEST

  conn = Faraday.new(:url => 'http://127.0.0.1:9292') do |faraday|
    faraday.request  :url_encoded
    faraday.response :logger
    faraday.adapter  Faraday.default_adapter
  end

  response = conn.get '/'
  puts response.body

  def test_it_can_get_a_request
    assert Faraday.get 'http://127.0.0.1:9292', server.success?
  end

  def test_it_can_send_a_response
  end

  def test_it_can_prep_a_response
  end

  def test_it_can_send_a_response
  end
end
