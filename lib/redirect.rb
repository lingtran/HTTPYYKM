module Redirect
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
end
