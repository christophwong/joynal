class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column :journal_entries, :sentiment_score, :float
  end

  def down
    change_column :journal_entries, :sentiment_score, :integer
  end
end
