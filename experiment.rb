# server side code

require 'socket'
tcp_server = TCPServer.new(9292) # establishes a server instance and has it listening to port 9292; essentially opens up a port (mailbox of an apartment building)
client = tcp_server.accept # will read request from the client object (i.e, an IO stream); client in this case is a browser

# following snippet is to keep reading from IO stream until a blank line and store all the requests in an array called the request_line
puts "Ready for a request"
request_lines = []
while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "Got this request:"
puts request_lines.inspect

puts "Sending response."
response = "<pre>" + request_lines.join("\n") + "<pre>"
output = "<html><head></head><body>#{response}</body></html>"
headers = ["http/1.1 200 ok",
          "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
          "server: ruby",
          "content-type: text/html; charset=iso-8859-1",
          "content-length: #{output.length}\r\n\r\n"].join("\r\n")
client.puts headers
client.puts output

puts ["Wrote this response:", headers, output].join("\n")
client.close
puts "\nRepsonse complete, exiting."
