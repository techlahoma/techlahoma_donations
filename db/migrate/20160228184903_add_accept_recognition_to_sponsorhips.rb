class AddAcceptRecognitionToSponsorhips < ActiveRecord::Migration
  def change
    add_column :sponsorships, :accept_recognition, :boolean, :default => true
  end
end
