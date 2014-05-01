class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user

  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true
end
