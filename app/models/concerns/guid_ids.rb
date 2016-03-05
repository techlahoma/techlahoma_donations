require 'active_support/concern'

module GuidIds
  extend ActiveSupport::Concern

  included do
    before_create :populate_guid
  end

  class_methods do
  end

  def populate_guid
    self.guid = SecureRandom.uuid()
  end

  def to_param
    guid
  end
end
