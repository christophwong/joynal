class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.integer :user_id
      t.string :content
      t.integer :emotion_rating
      t.timestamps
    end
  end
end
