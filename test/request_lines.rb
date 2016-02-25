module RequestLines

  def root_request
    ["GET / HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end

  def hello_request
    ["GET /hello HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end

  def datetime_request
    ["GET /datetime HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end

  def shutdown_request
    ["GET /shutdown HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end

  def word_search_request
    ["GET /word_search?word=cat HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end

  def word_search_request_2
    ["GET /word_search?word=pawsome HTTP/1.1",
   "User-Agent: Faraday v0.9.2",
   "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
   "Accept: */*",
   "Connection: close",
   "Host: 127.0.0.1:9292"]
  end
end
