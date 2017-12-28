class CreateDonationRollUps < ActiveRecord::Migration
  def change
    create_table :donation_roll_ups do |t|
      t.string :email
      t.decimal :amount
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps null: false
    end
  end
end
