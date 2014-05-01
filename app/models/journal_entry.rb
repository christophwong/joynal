class JournalEntry < ActiveRecord::Base
  has_many :tags, as: :taggable
  belongs_to :user
  # belongs_to :taggable
  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true
end
