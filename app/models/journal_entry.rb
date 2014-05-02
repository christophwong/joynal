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

  def set_sentiment_score
    response = self.get_sentiment
    if response['docSentiment'].key?('score')
      self.sentiment_score = integerize(response['docSentiment']['score'])
    end
  end

  def set_sentiment_type
    response = self.get_sentiment
    self.sentiment_type = (response['docSentiment']['type'])
  end

  def integerize(score)
    (score.to_f + 1.0) * 50
  end
end
