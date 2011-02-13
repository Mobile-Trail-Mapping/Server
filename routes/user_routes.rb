post '/user/add/?' do
  user = User.create(:email => params[:newuser], :pwhash => params[:newpwhash])
  return "Added user #{user.email}"
end

post '/user/check/?' do
  user = User.find(:email => params[:user], :pwhash => params[:pwhash])
  return "true" if not user.nil?
  return "false"
end

get '/user/delete/?' do
  user = User.all(:email => params[:newuser], :pwhash => params[:newpwhash])
  user.destroy unless user.nil?
end

