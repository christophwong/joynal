require 'faker'

FactoryGirl.define do
  factory :journal_entry do |f|
    f.user_id { rand(1..5)}
    f.content { Faker::Lorem.sentence }
    f.emotion_rating { rand(1..5)}
  end
end
