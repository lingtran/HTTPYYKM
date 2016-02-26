module Responses
  def response_diagnostics
    diagnostics = { "Verb:" => "",
                    "Path:" => "",
                    "Protocol:" => "",
                    "Host:" => "",
                    "Port:" => "",
                    "Origin:" => "",
                    "Accept:" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                  }
    diagnostics.each_pair do |key, value|
      if key == "Verb:"
        diagnostics[key] = filter_verb
      elsif key == "Path:"
        diagnostics[key] = filter_path
      elsif key == "Protocol:"
        diagnostics[key] = filter_protocol
      elsif key == "Host:" || key == "Origin:"
        diagnostics[key] = filter_host
      elsif key == "Port:"
        diagnostics[key] = @port
      else
        diagnostics[key] = value
      end
    end.map do |key, value|
      "#{key} #{value}\n"
    end.join.lstrip
  end

  def word_value_verification
    dictionary = File.readlines("/usr/share/dict/words")
    if dictionary.any? { |word| word.include?(filter_value) }
      "#{filter_value.upcase} is a known word"
    else
      "#{filter_value.upcase} is not a known word"
    end
  end

  def guess_input
    if filter_path == "GET"
      @guess = nil
    else
    content_length = @request_lines[3].split(": ")
    integer = content_length[1].to_i
    @guess = @client.read(integer).split("\r\n")[3].to_i
  end
    @guess
  end

  def root_response
    "<pre>\n#{response_diagnostics}</pre>"
  end

  def hello_response
    "<head> Hello, World! (#{@hello_counter})\n</head>
    <pre>
     \n#{response_diagnostics}
    </pre>"
  end

  def datetime_response
    "<head>#{Time.now.strftime("%I:%M%p on %A, %B %e, %Y")}\n</head>
    <pre>
    \n#{response_diagnostics}
    </pre>"
  end

  def shutdown_response
    "<head>Total Requests: #{@visited}\n</head>
    <pre>
    \n#{response_diagnostics}
    </pre>"
  end

  def word_search_response
    "<pre>
    \n #{word_value_verification}
    \n#{response_diagnostics}
    </pre>"
  end

  def start_game_response
    "<head><b> Good luck!</b>\n</head>
    <pre>
    \n#{response_diagnostics}
    </pre>"
  end

  def initial_game_response
    "<head><b><u>Here are the game stats:</u></b>\n</head>
    <pre>
    \nNil
    \nMost recent guess: What are you waiting for? Make a guess attempt!
    \nGuesses made: You know you want to make a guess.
    \n
    \n#{response_diagnostics}
    </pre>"
  end

  def get_game_response(guess_input)
    num_eval = @game.evaluate_number(guess_input)
    "<head><b><u>Here are the game stats:</u></b>\n</head>
    <pre>
    \n#{num_eval}
    \nMost recent guess: #{@guess}
    \nGuess attempts: #{@game_attempts}
    \n
    \n#{response_diagnostics}
    </pre>"
  end

end
