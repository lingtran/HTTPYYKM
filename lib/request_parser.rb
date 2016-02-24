require 'pry'
require 'server'

class RequestParser
  # take in request from client
  # parse out the response
  # inspect the path
  # provide response according to inspected path
end


# sample request_line for root (/) path:
# ["GET / HTTP/1.1",
#  "User-Agent: Faraday v0.9.2",
#  "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
#  "Accept: */*",
#  "Connection: close",
#  "Host: 127.0.0.1:9292"]

# response to be had for root (/) path request:
# response = "<pre>
#   Verb: POST
#   Path: /
#   Protocol: HTTP/1.1
#   Host: 127.0.0.1
#   Port: 9292
#   Origin: 127.0.0.1
#   Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
#   </pre>"
