class UpdateAcceptRecognitionOnDonations < ActiveRecord::Migration
  def change
    execute "update donations set accept_recognition = false where name = ''"
    execute "update donations set accept_recognition = false where name is null"
  end
end
