class AddRsvpToEventGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :event_guests, :rsvp, :boolean, default: false
  end
end
