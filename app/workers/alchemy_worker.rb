class AlchemyWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 5

  def perform(journal_id)
    journal_entry = JournalEntry.find(journal_id)
    journal_entry.set_keywords
    journal_entry.set_sentiment_score
    journal_entry.set_sentiment_type
    journal_entry.save
  end
end