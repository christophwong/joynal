class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user

  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true

  def get_sentiment(text)
    response = CLIENT.sentiment('text', text)
  end

  def get_keywords(text)
    response = CLIENT.keywords('text', text, { 'sentiment'=>1 })
  end


end
