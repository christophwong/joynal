require 'unirest'

counter = 1

50.times do
  puts "importing quote number #{counter}"
  response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=motivational",
    headers: {
      "X-Mashape-Authorization" => ENV["QUOTE_KEY"],
      "Accept" => "application/json"
    }

  Quote.create(body: response.body["contents"]["quote"],
              author: response.body["contents"]["author"])
  counter += 1
end

50.times do
  puts "importing quote number #{counter}"
  response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=inspirational",
    headers: {
      "X-Mashape-Authorization" => ENV["QUOTE_KEY"],
      "Accept" => "application/json"
    }

  Quote.create(body: response.body["contents"]["quote"],
              author: response.body["contents"]["author"])
  counter += 1
end

500.times do
  lat_lon = "POINT (#{Faker::Address.latitude} #{Faker::Address.longitude})"
  point = LocationRecord::GEOFACTORY.parse_wkt(lat_lon)
  LocationRecord.create(coords: point.projection) if point
end
