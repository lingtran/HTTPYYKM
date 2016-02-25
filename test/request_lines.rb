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

  def start_game_request
    ["POST /start_game HTTP/1.1",
     "Host: 127.0.0.1:9292",
     "Connection: keep-alive",
     "Content-Length: 138",
     "Cache-Control: no-cache",
     "Origin: chrome-extension://aicmkgpgakddgnaphhhpliifpcfhicfo",
     "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryqkTI4D7BEAOGOaHr",
     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
     "Postman-Token: a1485036-e45c-0bfd-8abb-e4ddab20c6b6",
     "Accept: */*",
     "DNT: 1",
     "Accept-Encoding: gzip, deflate",
     "Accept-Language: en-US,en;q=0.8"]
  end
end
