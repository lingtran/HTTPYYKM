require 'socket'
require_relative 'request_parser'
require 'pry'

class Server
  def initialize
    @tcp_server = TCPServer.new(9292)
    @visited = 0
    @request_lines = []
    end

  def parse_request
    @client = @tcp_server.accept
    puts "Ready for a request!"
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def prep_response
    puts "Got this request:"
    puts @request_lines.inspect
  end

  def send_response
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

    output = "<html><head></  head><body> Hello, World! (#{@visited}) \n #{response}</body></html>"

    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")

   @client.puts headers
   @client.puts output

  puts ["Wrote this response:", headers, output].join("\n")
  end

  def run_the_loop
    loop do
    @visited += 1
    parse_request
    prep_response
    send_response
    close_the_server
    @client.close
    end
  end

  def close_the_server
    puts "\nRepsonse complete, exiting."
  end

end

if __FILE__ == $0
  server = Server.new
  server.run_the_loop
end
