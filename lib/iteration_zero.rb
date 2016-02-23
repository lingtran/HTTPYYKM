# require filename with Faraday
require 'faraday'
require 'socket'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept

puts "Sending response"

# Server packages response based on request
# Client/Faraday sents request and then upon receipt of response from Server, "unwrap the response"

#
