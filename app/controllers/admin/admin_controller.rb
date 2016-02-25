class Admin::AdminController < ApplicationController

  before_filter :print_session
  #before_filter :login_required

  def print_session
    Rails.logger.debug "*"*30
    Rails.logger.debug session.as_json
    Rails.logger.debug "*"*30
  end

end
