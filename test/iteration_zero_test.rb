require '../lib/iteration_zero'
require 'faraday'

conn = Faraday.new(:url => 'http://127.0.0.1:9292/') do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

response = conn.get 'http://127.0.0.1:9292/'
response.body

# conn.get
#
# conn.get do |req|
#   req.url '/search', :page => 2
#   req.params['limit'] = 100
# end
