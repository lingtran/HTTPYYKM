require 'faraday'

conn = Faraday.new(:url => 'http://127.0.0.1:9292/') do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

response = conn.get '/'
response.body
