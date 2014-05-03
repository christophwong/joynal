require 'unirest'

counter = 1

5.times do 
  puts "importing quote number #{counter}"
  response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=motivational", 
    headers: { 
      "X-Mashape-Authorization" => "F20TS9fuhZSMpzfNs9LPEBFHKxmY4kKj",
      "Accept" => "application/json"
    }

  Quote.create(body: response.body["contents"]["quote"],
              author: response.body["contents"]["author"])
  counter += 1
end

5.times do 
  puts "importing quote number #{counter}"
  response = Unirest::get "https://theysaidso.p.mashape.com/quote?category=inspirational", 
    headers: { 
      "X-Mashape-Authorization" => "F20TS9fuhZSMpzfNs9LPEBFHKxmY4kKj",
      "Accept" => "application/json"
    }

  Quote.create(body: response.body["contents"]["quote"],
              author: response.body["contents"]["author"])
  counter += 1
end