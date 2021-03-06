require 'socket'

tcp_server = TCPServer.new(9292)

visited = 0
loop do
  client = tcp_server.accept
  visited += 1
  puts "Ready for a request!"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end
  puts "Got this request:"
  puts request_lines.inspect
  puts "Sending response."
  response = "<pre>
Verb: POST
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>"
  output = "<html><head></head><body> Hello, World! (#{visited}) \n #{response}</body></html>"
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
puts "\nResponse complete, exiting."
