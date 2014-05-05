class CreateLocationRecords < ActiveRecord::Migration
  def change
    create_table :location_records do |t|
      t.point :coords, :srid => 3785
      t.belongs_to :journal_entry

      t.timestamps
    end
  end
end
