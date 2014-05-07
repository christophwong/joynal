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

# JournalEntry.all.each do |entry|
#   lat_lon = "POINT (#{Faker::Address.latitude} #{Faker::Address.longitude})"
#   save_location(lat_lon, entry)
# end

# 1000.times do

# end
