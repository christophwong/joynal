require 'faker'

FactoryGirl.define do
  factory :journal_entry do |f|
    f.user_id { rand(1..5)}
    f.content { Faker::Lorem.sentence }
    f.emotion_rating { rand(1..5)}
  end
end


FactoryGirl.define do
	factory :invalid_journal_entry, parent: :journal_entry do |f|
       f.user_id { rand(1..5)}
    f.content nil
    f.emotion_rating { rand(1..5)}
	end
end