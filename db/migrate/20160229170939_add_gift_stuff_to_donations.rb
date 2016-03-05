class AddGiftStuffToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :plan_id, :string
    add_column :donations, :plan_name, :string
    add_column :donations, :address1, :string
    add_column :donations, :address2, :string
    add_column :donations, :city, :string
    add_column :donations, :state, :string
    add_column :donations, :zipcode, :string
    add_column :donations, :tee_shirt_size, :string
    add_column :donations, :tee_shirt_color, :string
    add_column :donations, :accept_gift, :boolean, :default => true
    add_column :donations, :polo_size, :string
    add_column :donations, :polo_color, :string
    add_column :donations, :hoodie_size, :string
    add_column :donations, :hoodie_color, :string
    add_column :donations, :gift_selected, :string
    add_column :donations, :accept_recognition, :boolean, :default => true
  end
end
