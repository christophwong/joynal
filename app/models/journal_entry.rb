class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user
  has_many :keywords

  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true

  def get_sentiment
    response = CLIENT.sentiment('text', self.content)
  end

  def get_keywords_response
    response = CLIENT.keywords('text', self.content, { 'sentiment'=>1 })
  end

  def set_keywords
    response = get_keywords_response
    response['keywords'].each do |keyword|
      new_keyword = Keyword.create(name: keyword['text'], relevance: keyword['relevance'], sentiment_score: keyword['sentiment']['score'], sentiment_type: keyword['sentiment']['type'])
      self.keywords << new_keyword
    end
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
