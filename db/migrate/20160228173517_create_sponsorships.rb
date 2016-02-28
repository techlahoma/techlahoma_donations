class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.string :email
      t.string :name
      t.decimal :amount
      t.string :guid
      t.string :token_id
      t.string :stripe_id
      t.string :stripe_status
      t.text :stripe_response
      t.text :plan_data

      t.timestamps null: false
    end
  end
end
