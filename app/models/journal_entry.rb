class JournalEntry < ActiveRecord::Base
  has_many :tags
  belongs_to :user

  acts_as_taggable_on :tags


  validates :content, presence: true
  validates :emotion_rating, presence: true


  def analyze(demo_text)

    response = CLIENT.entities('text', demo_text, { 'sentiment'=>1 })

  end
end
