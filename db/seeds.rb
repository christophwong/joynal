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

100.times do
  entry = JournalEntry.new(
    content: Faker::Lorem.paragraph(5),
    emotion_rating: rand(1..5),
    user: User.find(rand(User.first.id..User.last.id))
    )
  entry.sentiment_score = rand(-10..-5)/10.0
  lat_lon = "POINT (#{41.8613538 + rand(-10..10)/1000.0} #{-87.6929968+rand(-10..10)/1000.0})"
  save_location(lat_lon, entry)
end

