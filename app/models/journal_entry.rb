class JournalEntry < ActiveRecord::Base
  has_many :tags, as: :tagable
  belongs_to :user


  validates :content, presence: true
  validates :emotion_rating, presence: true
end
