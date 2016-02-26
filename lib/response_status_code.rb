# class ResponseStatusCode
#   include Filters, Redirect
#
#   def initialize(server)
#     @status_code = "202 ok"
#     @server = Server.self
#   end
#
#   def assign_status_code
#     if filter_path == "/start_game"
#       start_game_code
#     else
#       @status_code
#     end
#   end
#
#   def start_game_code
#     @status_code = "302 Found"
#   end
#
#   def game_path
#     # if verb = POST and path = /game
#     # give status code "302 Found"
#   end
# end
