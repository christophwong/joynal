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


    # t.integer  "user_id"
    # t.text     "content"
    # t.integer  "emotion_rating"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.integer  "sentiment_score"
    # t.string   "sentiment_type"