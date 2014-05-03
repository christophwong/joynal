class AddIndexToJournalEntries < ActiveRecord::Migration
  def change
    add_index :journal_entries, :user_id
  end
end
