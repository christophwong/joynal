class AddIndexToKeywords < ActiveRecord::Migration
  def change
    add_index :keywords, :journal_entry_id
    add_index :keywords, :name
  end
end
