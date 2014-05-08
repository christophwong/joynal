require 'faker'

FactoryGirl.define do
  factory :journal_entry do |f|
    f.user_id { rand(1..5)}
    f.content { Faker::Lorem.sentence }
  end
end


FactoryGirl.define do
	factory :invalid_journal_entry, parent: :journal_entry do |f|
       f.user_id { rand(1..5)}
    f.content nil
	end
end

