class ChangeDateToDateFrom < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :date, :date_from
  end
end
