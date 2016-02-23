require 'socket'

tcp_server = TCPServer.new(9292)
client = tcp_server.accept

visited = 0
loop do
  puts "Ready for a request!"
  request_lines = []

  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got this request:"
  puts request_lines.inspect
  visited += 1 # Question - noticed that number goes up to 2, then goes back to one, even when we don't exit pry. Is that normal?

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"
  output = "Hello World! (#{visited})"
  headers = ["http/1.1 200 ok",
             "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
             "server: ruby",
             "content-type: text/html; charset=iso-8859-1",
             "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  client.puts headers
  client.puts output
  puts ["Wrote this response:", headers, output].join("\n")
  client.close
end
