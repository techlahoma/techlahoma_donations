class AddGiftDeclinedAtToDonationRollUps < ActiveRecord::Migration
  def change
    add_column :donation_roll_ups, :gift_declined_at, :timestamp
  end
end
