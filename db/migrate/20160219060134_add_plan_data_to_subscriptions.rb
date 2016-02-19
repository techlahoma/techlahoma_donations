class AddPlanDataToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :interval, :string
    add_column :subscriptions, :interval_count, :integer
    add_column :subscriptions, :plan_name, :string
  end
end
