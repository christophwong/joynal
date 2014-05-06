class CreateLocationRecords < ActiveRecord::Migration
  def change
    create_table :location_records do |t|
      t.belongs_to :journal_entry
      t.point :location, :geographic => true
    end
    change_table :location_records do |t|
      t.index :location, :spatial => true  
    end
  end
end
