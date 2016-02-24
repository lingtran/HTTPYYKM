module Responses

  def root_response
    "<pre>
    Verb: POST
    Path: /
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
    </pre>"
  end

  def hello_response
    "<html><head></head><body> Hello, World! (#{@hello_counter})\n <pre>
    Verb: POST
    Path: /hello
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
    </pre></body></html>"
  end

  def datetime_response
    "<html><head></head><body> #{Time.now.strftime('%I:%M%p on %A, %B %e, %Y')}\n <pre>
    Verb: POST
    Path: /datetime
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
    </pre></body></html>"
  end

  def shutdown_response
    "<html><head></head><body> Total Requests: #{@visited}\n <pre>
    Verb: POST
    Path: /shutdown
    Protocol: HTTP/1.1
    Host: 127.0.0.1
    Port: 9292
    Origin: 127.0.0.1
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
    </pre></body></html>"
  end
end
