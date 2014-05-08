class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :journal_entries

  def get_keywords_by_dates
    self.journal_entries.joins(:keywords)
    .where(journal_entries: {created_at: (Time.now - 30.day)..Time.now }).limit(60)
    .group("keywords.name")
    .pluck("keywords.name, AVG(keywords.sentiment_score), COUNT(keywords.name)")
  end

  def jsonify_keywords
    keywords_array = self.get_keywords_by_dates
    json_array = []
    keywords_array.each do |keyword|
      json = Hash.new(0)
      json['name'] = keyword[0]
      json['sentiment_score'] = keyword[1]
      json['value'] = keyword[2]
      json_array << json
    end
    json_array
  end

  def get_journal_coords
    json_array = []
    self.journal_entries.each do |entry|
      json = Hash.new(0)
      json[:id] = entry.id
      json[:date] = entry.date
      json[:sentiment_score] = entry.sentiment_score
      json[:content] = entry.content
      unless entry.location_records.empty? || entry.location_records.first.location.nil?
        json[:latitude] = entry.location_records.first.location.x.to_f
        json[:longitude] = entry.location_records.first.location.y.to_f
        json_array << json
      end
    end
    return json_array
  end


end
