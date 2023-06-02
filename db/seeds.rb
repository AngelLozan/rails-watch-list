require 'uri'
require 'net/http'
require 'openssl'
require 'json'

puts "Adding a photo to one list... "
file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")
list = List.new(name: "NES")
list.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
list.save
puts "Photo added to #{list.name} list!"

# Actions for seeding movies to db
url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = "Bearer #{ENV['MOVIE_KEY']}"


response = http.request(request)
response = JSON.parse(response.read_body) # type: Hash
results = response["results"].sample(10) # type: Array

puts "Creating movies..."

results.each do |res| #
  Movie.create(title: res["title"], overview: res["overview"], poster_url: "https://image.tmdb.org/t/p/original#{res["poster_path"]}", rating: res["vote_average"])
  puts "Created #{res["title"]}:  https://image.tmdb.org/t/p/original#{res["poster_path"]}"
end

puts "Finished!"
