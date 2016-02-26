require 'socket'
require 'pry'
require_relative 'filters'
require_relative 'responses'
require_relative 'redirect'
require_relative 'game'

class Server < Game
  include Responses, Filters, Redirect

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
      @status_code = "200 ok"
      start_game_response
    elsif filter_path == "/game"
      @status_code = "200 ok"
      if @game_attempts < 0
        initial_game_response
      elsif @game_attempts > 1
        get_game_response
      end
    elsif filter_verb == "POST" && filter_path.start_with?("/game?")
      @game_attempts += 1
      @status_code = "302 Found"
      get_game_response
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
