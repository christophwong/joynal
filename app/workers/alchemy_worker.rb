class AlchemyWorker
  include Sidekiq::Worker

  def perform(journal_id)
    journal_entry = Journal.find(journal_id)
    journal_entry.set_keywords
    journal_entry.set_sentiment_score
    journal_entry.set_sentiment_type
  end
end