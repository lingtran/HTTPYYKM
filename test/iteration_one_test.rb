require 'faraday'

conn = Faraday.new(:url => '') do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

response = conn.get '/'
response.body
