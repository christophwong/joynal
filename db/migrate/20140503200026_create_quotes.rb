class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :author
    end
  end
end
