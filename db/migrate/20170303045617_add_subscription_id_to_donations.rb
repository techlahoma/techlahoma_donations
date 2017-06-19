class AddSubscriptionIdToDonations < ActiveRecord::Migration
  def change
    add_reference :donations, :subscription, index: true, foreign_key: true
  end
end
