class AddPoloAttsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :polo_size, :string
    add_column :subscriptions, :polo_color, :string
  end
end
