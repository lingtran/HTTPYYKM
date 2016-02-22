require 'socket'
tcp_server = TCPServer.new(9292) # establishes a server instance and has it listening to port 9292
client = tcp_server.accept # will read request from the client object (i.e, an IO stream)

puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end 
