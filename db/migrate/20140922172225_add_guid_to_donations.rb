class AddGuidToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :guid, :string
  end
end
