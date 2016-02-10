class AddStripeFieldsToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_id, :string
    add_column :donations, :stripe_status, :string
  end
end
