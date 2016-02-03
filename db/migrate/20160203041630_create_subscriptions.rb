class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :email
      t.belongs_to :plan, index: true
      t.integer :amount
      t.string :token_id

      t.string   "guid"
      t.text     "stripe_response"
      t.string   "stripe_id"
      t.string   "stripe_customer_id"
      t.string   "stripe_subscription_id"
      t.datetime "current_period_start"
      t.datetime "current_period_end"
      t.datetime "ended_at"
      t.datetime "trial_start"
      t.datetime "trial_end"
      t.datetime "canceled_at"
      t.integer  "quantity"
      t.string   "stripe_status"
      t.boolean  "cancel_at_period_end"

      t.timestamps
    end
  end
end
