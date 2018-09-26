class ChangeDateFromType < ActiveRecord::Migration[5.2]
  def change
     change_column :events, :date_from, :date
  end
end
