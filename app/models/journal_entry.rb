class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user
  has_many :keywords

  after_create :add_date
  after_commit :async_sentimental_analysis, :on => :create
  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true

  def async_sentimental_analysis
    AlchemyWorker.perform_async(self.id)
  end

  def get_sentiment
    CLIENT.sentiment('text', self.content)
  end

  def get_keywords_response
    CLIENT.keywords('text', self.content, { 'sentiment'=>1 })
  end

  def set_keywords
    response = get_keywords_response
    if response['keywords']
      response['keywords'].each do |keyword|
        score = keyword['sentiment']['score'] || 0
        new_keyword = Keyword.create(name: keyword['text'], relevance: keyword['relevance'], sentiment_score: score, sentiment_type: keyword['sentiment']['type'])
        self.keywords << new_keyword
      end
    end
  end

  def set_sentiment_score
    response = self.get_sentiment
    if response['docSentiment'].key?('score')
      self.sentiment_score = response['docSentiment']['score']
    else
      self.sentiment_score = 0
    end
  end

  def set_sentiment_type
    response = self.get_sentiment
    self.sentiment_type = response['docSentiment']['type']
  end

  def add_date
    date = Time.now
    d = date.strftime('%Y-%m-%d')
    self.update_attributes(date: d)
  end
end
