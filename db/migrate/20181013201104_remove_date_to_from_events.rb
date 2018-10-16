class RemoveDateToFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :date_to, :integer
  end
end
