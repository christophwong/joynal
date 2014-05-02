class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.integer :journal_entry_id
      t.string :name
      t.float :relevance
      t.float :sentiment_score
      t.string :sentiment_type
    end
  end
end
