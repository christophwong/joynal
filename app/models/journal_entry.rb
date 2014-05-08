class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user
  has_many :keywords
  has_many :location_records

  # after_create :add_date
  after_commit :async_sentimental_analysis, :on => :create
  acts_as_taggable_on :tags


  validates :content, presence: true

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

  def jsonify_journal_keywords
    json_array = []
    journal_entry_keywords = self.keywords.group_by(&:sentiment_type).each do |key, value|
      json = Hash.new(0)
      json[:sentiment_type] = key
      json[:keywords] = value
      json_array << json
    end
    json_array
  end

  def self.get_all_journal_coords
    json_array = []
    self.all.each do |entry|
      json = Hash.new(0)
      json[:id] = entry.id
      json[:date] = entry.date
      json[:sentiment_score] = entry.sentiment_score
      unless entry.location_records.empty? || entry.location_records.first.location.nil?
        json[:latitude] = entry.location_records.first.location.x.to_f
        json[:longitude] = entry.location_records.first.location.y.to_f
        json_array << json
      end
    end
    return json_array
  end
end
