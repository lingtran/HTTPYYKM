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
    # issue where the "verb" line gets indented when others don't
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

  def filtered_host # problem to resolve: the index of host changes depending on the client, need to find this and then split it
    @request_lines[1].split(":")[1]
  end

  def root_response
    "<pre>#{response_diagnostics}</pre>"
  end

  def hello_response
    "<html><head></head><body>
    Hello, World! (#{@hello_counter})\n
    <pre>
    #{response_diagnostics}
    </pre>
    </body></html>"
  end

  def datetime_response
    "<html><head></head><body>
    #{Time.now.strftime("%I:%M%p on %A, %B %e, %Y")}\n
    <pre>
    #{response_diagnostics}
    </pre>
    </body></html>"
  end

  def shutdown_response
    "<html><head></head><body> Total Requests: #{@visited}\n <pre>
    #{response_diagnostics}
    </pre><
    /body></html>"
  end
end
