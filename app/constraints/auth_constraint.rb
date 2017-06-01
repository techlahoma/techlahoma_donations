class AuthConstraint
  def self.admin?(request)
    if request.session[:user_id].present?
      user = User.find request.session[:user_id]
      return user.admin
    else
      return false
    end
  end
end
