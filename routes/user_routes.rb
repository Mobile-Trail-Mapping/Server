# Add a new user
post '/user/add/?' do
  user = User.create(:email => params[:newuser], :pwhash => params[:newpwhash])

  redirect '/trails'
end

# Check if user credentials are valid
post '/user/check/?' do
  user = User.find(:email => params[:user], :pwhash => params[:pwhash])
  return "true" if not user.nil?
  return "false"
end

# Delete a user
get '/user/delete/?' do
  user = User.all(:email => params[:newuser], :pwhash => params[:newpwhash])
  user.destroy unless user.nil?
end

get '/user/is_admin?/?' do
  user = User.first(:email => params[:user], :pwhash => params[:pwhash])

  user.admin?
end

post '/user/login/?' do
  pwhash = Digest::SHA1.hexdigest(params[:password])

  if not password_doesnt_match_user?(params[:user], pwhash)
    session[:user] = params[:user]
    session[:pwhash] = pwhash

    redirect '/trails'
  else
    return "Invalid username and password"
  end
end
