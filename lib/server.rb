require 'socket'
require 'pry'
require_relative 'filters'
require_relative 'responses'
require_relative 'redirect'
require_relative 'game'

class Server
  include Responses, Filters

  attr_reader :tcp_server, :client, :request_lines

  def initialize
    @port = 9292
    @tcp_server = TCPServer.new(@port)
    @visited = 0
    @hello_counter = 0
    @game_attempts = 0
    @request_lines = []
    @status_code = "200 ok"
  end

  def accept_request
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
    # puts @client.read(138)
  end

  def send_response
    puts "Sending response."
    output = "<html><body>#{assign_response}</body></html>"
    headers = ["http/1.1 #{@status_code}",
               "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
               "server: ruby",
               "content-type: text/html; charset=iso-8859-1",
               "content-length: #{output.length}\r\n\r\n"]

    headers.insert(1, game_location) if @status_code == "302 Found"

    headers = headers.join("\r\n")

    @client.puts headers
    @client.puts output
    puts ["Wrote this response:", headers, output].join("\n")
  end

  def game_location
    "Location: http://127.0.0.1:9292/game"
  end

  def assign_response
    if filter_path == "/shutdown"
      @status_code = "200 ok"
      shutdown_response
    elsif filter_path == "/hello"
      @hello_counter += 1
      @status_code = "200 ok"
      hello_response
    elsif filter_path == "/datetime"
      @status_code = "200 ok"
      datetime_response
    elsif filter_path == "/word_search"
      @status_code = "200 ok"
      word_search_response
    elsif filter_path == "/start_game"
      @status_code = "302 Found"
      start_game_response
            # initialize a new game, store it in an instance variable
    elsif filter_verb == "GET" && filter_path == "/game"
      @status_code = "200 ok"
      if @game_attempts == 0
        initial_game_response
      elsif @game_attempts >= 1
        get_game_response
      end
    elsif filter_verb == "POST" && filter_path.start_with?("/game?")
      @game_attempts += 1
      @status_code = "302 Found"
      get_game_response
      # use intance variable to evaluate number by passing in request lines
    else
      @status_code = "200 ok"
      root_response
    end
  end

  def close_the_server
    puts "\nResponse complete, exiting."
  end

  def run_the_loop
    loop do
      accept_request
      inspect_request
      send_response
      @visited += 1
      break if filter_path == "/shutdown"
      @client.close
    end
    close_the_server
  end
end

if __FILE__ == $0
  server = Server.new
  server.run_the_loop
end
