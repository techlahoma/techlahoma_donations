class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :amount
      t.string :interval
      t.integer :interval_count, :default => 1
      t.string :name
      t.string :stripe_id


      t.timestamps
    end
  end
end
