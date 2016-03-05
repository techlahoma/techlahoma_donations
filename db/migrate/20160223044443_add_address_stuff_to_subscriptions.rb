class AddAddressStuffToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :address1, :string
    add_column :subscriptions, :address2, :string
    add_column :subscriptions, :city, :string
    add_column :subscriptions, :state, :string
    add_column :subscriptions, :zipcode, :string
  end
end
