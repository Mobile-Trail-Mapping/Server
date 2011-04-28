class MTM
  # Add a new user
  post '/user/add/?' do
    user = User.create(:email => params[:newuser], :pwhash => params[:newpwhash])

    redirect '/trails'
  end

  # Check if user credentials are valid
  post '/user/check/?' do
    user = User.first(:email => params[:user], :pwhash => params[:pwhash])
    return "admin" if !user.nil? && user.admin
    return "user" if !user.nil? && !user.admin
    return "invalid"
  end

  # Delete a user
  get '/user/delete/?' do
    user = User.all(:email => params[:newuser], :pwhash => params[:newpwhash])
    user.destroy unless user.nil?
  end

  get '/user/toggle_admin/?' do
    user = User.first(:email => params[:to_change_user], :pwhash => params[:to_change_pwhash])
    current_user = User.first(:email => params[:user])

    if current_user.admin
      user.admin = user.admin ? false : true

      "Set admin flag to #{user.admin}"
    else
      "You must be an admin to change set a user as an admin"
    end
  end

  post '/user/make_admin' do
    user = User.first(:email => params[:user], :pwhash => params[:pwhash])

    user.admin = true
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
end
