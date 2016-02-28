class AddPlanIdToSponsorships < ActiveRecord::Migration
  def change
    add_column :sponsorships, :plan_id, :string
  end
end
