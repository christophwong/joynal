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
#     user: User.find(rand(User.first.id..User.last.id))
#     )
#   entry.sentiment_score = rand(-10..-5)/10.0
#   lat_lon = "POINT (#{41.8613538 + rand(-10..10)/1000.0} #{-87.6929968+rand(-10..10)/1000.0})"
#   save_location(lat_lon, entry)
# end


# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "NuS3bc0z3xx5w66Tn9zgyd2uI"
#   config.consumer_secret    = ENV['CONSUMER_SECRET']
#   config.access_token        = "33998273-iX45VdrCQrfSwQ2f2EoMbegS4b1AeDlai1BNpxZ4H"
#   config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
# end

# bourdain = User.create(first_name: "Anthony", last_name: "Bourdain", email: 'anthony@http://bourdain.com', password: "password", password_confirmation: "password" )

# client.user_timeline("Bourdain", {count: 15}).each do |tweet|
#   emotion_rating = rand(1..5)
#   lat_lon = "POINT (#{Faker::Address.latitude} #{Faker::Address.longitude})"
#   j = JournalEntry.create(user_id: http://bourdain.id ,content: tweet.text, emotion_rating: emotion_rating)
#   LocationRecord.create(journal_entry: j, location: lat_lon)
# end

san_francisco =
[
[37.7648287,-122.452712],
[37.7490556,-122.4344773],
[37.7500393,-122.4840656],
[37.7162374,-122.414285],
[37.724134,-122.4209454],
[37.7174806,-122.4619725],
[37.751624,-122.4593117],
[37.8047122,-122.4081963],
[37.7920974,-122.4029178]
]

new_york =
[
[40.7590615,-73.969231],
[40.8004355,-73.9422486],
[40.815665,-73.9480885],
[40.7870814,-73.8092395],
[40.8381335,-73.8582039],
[40.7870814,-73.8092395],
[40.815665,-73.9480885],
[40.8305019,-73.940918],
[40.8204264,-73.9871911],
[40.85166,-73.840934],
[40.8638528,-73.5323146]
]

chicago = [
[41.8899109,-87.6376566],
[41.8677395,-87.6270511],
[41.9738814,-87.6903942],
[41.9318204,-88.006109],
[41.8202997,-87.8087842],
[41.8942655,-88.1527993],
[42.3318145,-88.9952953]
]

washington_dc =
[
[38.8935965,-77.014576],
[38.930661,-77.0886],
[38.9320799,-77.0223758],
[38.854201,-76.966258],
[38.8405745,-76.9954474],
[38.8469485,-77.128849],
[38.981727,-77.1185768],
[39.0085992,-77.0178444],
[39.0085992,-77.0178444]
]

houston =
[
[29.817178,-95.4012915],
[29.6623309,-95.3206145],
[29.660633,-95.2286764],
[29.6687526,-95.5004895],
[29.865076,-95.3873649],
[29.790639,-95.110674],
[29.7313824,-95.3606554],
[29.7427795,-95.232755],
[29.6358874,-95.4384429],
[29.9446504,-96.265735],
[29.7806644,-95.9566609],
[30.1683335,-95.5238509],
[30.0632925,-95.2062839],
[29.7458199,-94.9527543]
]

san_antonio =
[
[29.4814305,-98.5144044],
[29.5320945,-98.5334487],
[29.498967,-98.7032741],
[29.5373816,-98.4209729],
[29.4765094,-98.4455284],
[29.478189,-98.4368218],
[29.4982774,-98.6150749],
[29.6971259,-98.4826189]
]

seattle =
[
[47.614848,-122.3358423],
[47.556309,-122.3028474],
[47.502927,-122.349586],
[47.5433705,-122.2707346],
[47.6475984,-122.5361625],
[47.669724,-122.121578],
[47.7927335,-122.3072681],
[47.812594,-122.192556],
[47.6080113,-122.0311651],
[47.6776212,-122.3871803],
[47.3856529,-122.205749],
[47.502927,-122.349586],
[47.4815449,-122.1935124]
]

miami =
[
[25.782324,-80.2310801],
[25.7757013,-80.2278733],
[25.8388744,-80.2337555],
[25.8139542,-80.1443065],
[25.6718539,-80.3470704],
[25.8186434,-80.3541725],
[26.1411125,-80.149973],
[26.103745,-80.4063059]
]

JournalEntry.all.each do |entry|
  sample_coord = chicago.sample
  l = entry.location_records.first
  l.location = "POINT (#{sample_coord[1]} #{sample_coord[0]})"
  l.save
end

kingsly = User.new(
  first_name: "Kingsly",
  last_name: "Rutherford III",
  email: "kingsly@rutherfordiii.com",
  password: "password",
  password_confirmation: "password"
)

kingsly.save

pastday = 90
cities = [san_francisco,miami,new_york,san_antonio,houston,seattle,washington_dc]
flat_city = cities.flatten(1)
tag_array = ['life', 'devise', 'alchemy', 'math', 'vegas', 'closure']
p flat_city.sample[0]

File.open('db/website_full_of_essays_and_philosophy.txt').each do |line|

  t = Time.now - ((60 * 60 * 24) * rand(0..pastday))
  date = t.strftime "%Y-%m-%d"

  je = JournalEntry.create(
    content: line,
    user_id: kingsly.id,
    date: date
    )

  sample_coord = flat_city.sample

  lat_lon = "POINT (#{sample_coord[1]} #{sample_coord[0]})"

  LocationRecord.create(
    journal_entry_id: je.id,
    location: lat_lon
    )

  je.tag_list.add(tag_array.sample)

end


