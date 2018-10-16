class ChangeDateFromName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :date_from, :date
  end
end
