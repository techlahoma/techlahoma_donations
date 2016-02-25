class AddAcceptGiftToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :accept_gift, :boolean, :default => true
  end
end
