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
        diagnostics[key] = filtered_verb
      elsif key == "Path:"
        diagnostics[key] = filtered_path
      elsif key == "Protocol:"
        diagnostics[key] = filtered_protocol
      elsif key == "Host:" || key == "Origin:"
        diagnostics[key] = filtered_host
      elsif key == "Port:"
        diagnostics[key] = @port
      else
        diagnostics[key] = value
      end
    end.map do |key, value|
      "#{key} #{value}\n"
    end.join.lstrip
  end

  def filtered_verb
    @request_lines[0].split[0]
  end

  def filtered_path
    @request_lines[0].split[1]
  end

  def filtered_protocol
    @request_lines[0].split[2]
  end

  def filtered_host
    @request_lines.find { |element| element if element.include?("Host:") }.split(":")[1].lstrip
  end

  def root_response
    "<pre>\n#{response_diagnostics}</pre>"
  end

  def hello_response
    "<head>Hello, World! (#{@hello_counter})\n</head>
    <pre>
     \n#{response_diagnostics}
    </pre>"
  end

  def datetime_response
    "#{Time.now.strftime("%I:%M%p on %A, %B %e, %Y")}\n
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
end
