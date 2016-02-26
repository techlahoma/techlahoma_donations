class AddGiftSelectedToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :gift_selected, :string
  end
end
