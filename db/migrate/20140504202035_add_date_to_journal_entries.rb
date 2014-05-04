class AddDateToJournalEntries < ActiveRecord::Migration
  def change
    add_column :journal_entries, :date , :string
  end
end
