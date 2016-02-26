class AddHoodieAttsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :hoodie_size, :string
    add_column :subscriptions, :hoodie_color, :string
  end
end
