require 'socket'
# require_relative 'request_parser'
require 'pry'
require_relative 'responses'

class Server
  include Responses
  attr_reader :tcp_server

  def initialize
    @port = 9292
    @tcp_server = TCPServer.new(@port)
    @visited = 0
    @hello_counter = 0
    @request_lines = []
  end

  def parse_request
    @client = tcp_server.accept
    puts "Ready for a request!"
    @request_lines.clear
    while line = @client.gets and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def inspect_request
    puts "Got this request:"
    puts @request_lines.inspect
  end

  def response
    path_finder = @request_lines.fetch(0)
    if path_finder.include?("/hello")
      @hello_counter +=1
      hello_response
    elsif path_finder.include?("/datetime")
      datetime_response
    elsif path_finder.include?("/shutdown")
      shutdown_response
    else
      root_response
    end
  end

  def send_response
    puts "Sending response."
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    @client.puts headers
    @client.puts output
   puts ["Wrote this response:", headers, output].join("\n")
  end

  def close_the_server
    puts "\nResponse complete, exiting."
  end

  def run_the_loop
    loop do
      parse_request
      inspect_request
      send_response
      @visited += 1
      break if @request_lines[0].include?("/shutdown")
    end
    close_the_server
    @client.close

  end

end

if __FILE__ == $0
  server = Server.new
  server.run_the_loop
end
