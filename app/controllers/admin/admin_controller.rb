class Admin::AdminController < ApplicationController

  before_filter :print_session
  before_filter :login_required
  before_filter :admin_user_required

  def admin_user_required
    unless current_user.admin?
      redirect_to root_path
    end
  end
  def print_session
    Rails.logger.debug "*"*30
    Rails.logger.debug session.as_json
    Rails.logger.debug "*"*30
  end

end
