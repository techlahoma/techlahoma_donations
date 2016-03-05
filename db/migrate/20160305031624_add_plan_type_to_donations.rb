class AddPlanTypeToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :plan_type, :string
  end
end
