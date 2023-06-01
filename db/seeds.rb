require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4M2QyNDA2MDNhMmEwMGZhZGJiMGU5ZGZhY2E2NDQyYSIsInN1YiI6IjY0Nzg2YjgwY2Y0YjhiMDBlMmQ0NmJlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SiFmx1MR8aO6gHdMBl4ht7qctNQn1U6_FBqaX64SyUY'

response = http.request(request)
response = JSON.parse(response.read_body) # type: Hash
results = response["results"].sample(10) # type: Array

puts "Creating movies..."

results.each do |res| #
  Movie.create(title: res["title"], overview: res["overview"], poster_url: "https://image.tmdb.org/t/p/original#{res["poster_path"]}", rating: res["vote_average"])
  puts "Created #{res["title"]}:  https://image.tmdb.org/t/p/original#{res["poster_path"]}"
end

puts "Finished!"
