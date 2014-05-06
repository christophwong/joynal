class CreateLocationRecords < ActiveRecord::Migration
  def change
    create_table :location_records do |t|
      t.belongs_to :journal_entry
      t.point :coords, :srid => 3785
    end
    change_table :location_records do |t|
      t.index :coords, :spatial => true
    end
  end
end
