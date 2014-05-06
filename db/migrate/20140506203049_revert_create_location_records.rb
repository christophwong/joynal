require_relative '20140505173031_create_location_records'

class RevertCreateLocationRecords < ActiveRecord::Migration
  def change
    revert CreateLocationRecords

    create_table :location_records do |t|
      t.belongs_to :journal_entry
      t.point :location, :geographic => true
    end
    change_table :location_records do |t|
      t.index :location, :spatial => true
    end

  end
end
