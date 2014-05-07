require 'unirest'

# counter = 1

# 50.times do
#   puts "importing quote number #{counter}"
#   response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=motivational",
#     headers: {
#       "X-Mashape-Authorization" => ENV["QUOTE_KEY"],
#       "Accept" => "application/json"
#     }

#   Quote.create(body: response.body["contents"]["quote"],
#               author: response.body["contents"]["author"])
#   counter += 1
# end

# 50.times do
#   puts "importing quote number #{counter}"
#   response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=inspirational",
#     headers: {
#       "X-Mashape-Authorization" => ENV["QUOTE_KEY"],
#       "Accept" => "application/json"
#     }

#   Quote.create(body: response.body["contents"]["quote"],
#               author: response.body["contents"]["author"])
#   counter += 1
# end

# make sure all journal entries have locations

def save_location(lat_lon, journal)
  LocationRecord.create(journal_entry: journal, location: lat_lon)
end

# make fake journal entries
# 1000.times do
#   entry = JournalEntry.new(
#     content: Faker::Lorem.paragraph(5),
#     emotion_rating: rand(1..5),
#     user: User.find(1)
#     )
#   lat_lon = "POINT (#{41.8613538 + rand(-10..10)/10.0} #{-87.6929968+rand(-10..10)/10.0})"
#   save_location(lat_lon, entry)
# end

# assign random location data
# JournalEntry.all.each do |entry|
#   lat_lon = "POINT (#{41.8613538 + rand(-10..10)/10.0} #{-87.6929968+rand(-10..10)/10.0})"
#   save_location(lat_lon, entry)
# end

# assign random user
# JournalEntry.all.each do |entry|
#   entry.update_attributes(user: User.find(rand(User.first.id..User.last.id)))
# end

# assign random sentiment_score

# 100.times do
#   entry = JournalEntry.new(
#     content: Faker::Lorem.paragraph(5),
#     emotion_rating: rand(1..5),
#     user: User.find(rand(User.first.id..User.last.id))
#     )
#   entry.sentiment_score = rand(-10..-5)/10.0
#   lat_lon = "POINT (#{41.8613538 + rand(-10..10)/1000.0} #{-87.6929968+rand(-10..10)/1000.0})"
#   save_location(lat_lon, entry)
# end


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "NuS3bc0z3xx5w66Tn9zgyd2uI"
  config.consumer_secret    = ENV['CONSUMER_SECRET']
  config.access_token        = "33998273-iX45VdrCQrfSwQ2f2EoMbegS4b1AeDlai1BNpxZ4H"
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

bourdain = User.create(first_name: "Anthony", last_name: "Bourdain", email: 'anthony@http://bourdain.com', password: "password", password_confirmation: "password" )

client.user_timeline("Bourdain", {count: 15}).each do |tweet|
  emotion_rating = rand(1..5)
  lat_lon = "POINT (#{Faker::Address.latitude} #{Faker::Address.longitude})"
  j = JournalEntry.create(user_id: http://bourdain.id ,content: tweet.text, emotion_rating: emotion_rating)
  LocationRecord.create(journal_entry: j, location: lat_lon)
end
