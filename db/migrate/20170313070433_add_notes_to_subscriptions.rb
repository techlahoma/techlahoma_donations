class AddNotesToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :notes, :text
  end
end
