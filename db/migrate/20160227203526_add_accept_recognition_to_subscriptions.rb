class AddAcceptRecognitionToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :accept_recognition, :boolean, :default => true
  end
end
