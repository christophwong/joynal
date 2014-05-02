class AddColumnsToJournalEntries < ActiveRecord::Migration
  def change
    add_column :journal_entries, :sentiment_score, :integer
    add_column :journal_entries, :sentiment_type, :string
  end
end
