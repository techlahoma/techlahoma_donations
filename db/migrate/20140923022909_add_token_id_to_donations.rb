class AddTokenIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :token_id, :string
  end
end
