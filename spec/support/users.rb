def login_user(user)
  session[:user_id] = user.id
  cookies[:techlahoma_auth] = {:value => user.id}
end
