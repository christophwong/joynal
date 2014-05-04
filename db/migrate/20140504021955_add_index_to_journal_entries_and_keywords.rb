class AddIndexToJournalEntriesAndKeywords < ActiveRecord::Migration
  def change
    add_index :journal_entries, :created_at
    add_index :keywords, :sentiment_score
  end
end
