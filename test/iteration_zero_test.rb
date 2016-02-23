require '../lib/iteration_zero'
require 'faraday'


response = Faraday.get 'http://127.0.0.1:9292'

puts response.body
