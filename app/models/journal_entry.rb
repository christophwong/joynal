class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user

  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true

  def get_sentiment
    response = CLIENT.sentiment('text', self.content)
  end

  def get_keywords
    response = CLIENT.keywords('text', self.content, { 'sentiment'=>1 })
  end


end
