require 'faraday'

conn = Faraday.new(:url => 'http://127.0.0.1:9292') do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

response = conn.get '/'
puts response.body


# conn.get do |req|
#   req.url '/hello'
#   req.options.timeout = 5           # open/read timeout in seconds
#   req.options.open_timeout = 2      # connection open timeout in seconds
# end
