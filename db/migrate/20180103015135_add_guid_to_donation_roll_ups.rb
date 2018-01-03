class AddGuidToDonationRollUps < ActiveRecord::Migration
  def change
    add_column :donation_roll_ups, :guid, :string
  end
end
