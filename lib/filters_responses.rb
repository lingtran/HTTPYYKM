module Filters
  def filter_verb
    @request_lines[0].split[0]
  end

  def filter_path
    filter_path = @request_lines[0].split[1]
    if filter_path.split("?")[0].include?("/word_search")
      filter_path = filter_path.split("?")[0]
    else
      filter_path
    end
  end

  def filter_protocol
    @request_lines[0].split[2]
  end

  def filter_host
    @request_lines.find { |element| element if element.include?("Host:") }.split(":")[1].lstrip
  end

  def filter_parameter
    @request_lines[0].split[1].split("?")[1].split("=")[0]
  end

  def filter_value
    @request_lines[0].split[1].split("?")[1].split("=")[1].downcase
  end
end

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
end
