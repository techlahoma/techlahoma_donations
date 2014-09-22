class Donation < ActiveRecord::Base

  before_create :populate_guid
  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end

end
