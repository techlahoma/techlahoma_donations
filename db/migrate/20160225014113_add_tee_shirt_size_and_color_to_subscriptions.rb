class AddTeeShirtSizeAndColorToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :tee_shirt_size, :string
    add_column :subscriptions, :tee_shirt_color, :string
  end
end
