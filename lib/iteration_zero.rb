# require filename with Faraday

require '../test/iteration_zero_test'
require 'socket'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept

# request_counter = 0
# request_lines = []
# while line = client.gets and !line.chomp.empty?
#   request_lines << line.chomp
#   # request_counter += 1
# end
client.gets
client.puts "Hello, World! (0)"


client.close
puts "\nResponse complete, exiting."

# Server packages response based on request
# Client/Faraday sents request and then upon receipt of response from Server, "unwrap the response"

#
