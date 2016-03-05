class AddStripeResponseToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :stripe_response, :text
  end
end
