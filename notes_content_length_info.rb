[6] pry(#<Server>)> content_length = array[3]
=> "Content-Length: 138"
[7] pry(#<Server>)> content_length = array[3].split(": ")
=> ["Content-Length", "138"]
[8] pry(#<Server>)> @client.read(content_length)
TypeError: no implicit conversion of Array into Integer
from (pry):20:in `read'
[9] pry(#<Server>)> @client.read(content_length[1])
TypeError: no implicit conversion of String into Integer
from (pry):21:in `read'
[10] pry(#<Server>)> content_length[1]
=> "138"
[11] pry(#<Server>)> integer = content_length[1]
=> "138"
[12] pry(#<Server>)> integer = content_length[1].to_i
=> 138
[13] pry(#<Server>)> @client.read(integer)
=> "------WebKitFormBoundaryZV47ERG6i9K6ekQY\r\nContent-Disposition: form-data; name=\"guess\"\r\n\r\n20\r\n------WebKitFormBoundaryZV47ERG6i9K6ekQY--\r\n"
[14] pry(#<Server>)> @client.read(integer).split("\n")
