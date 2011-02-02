post '/user/add' do
  user = User.create(:email => params[:user], :pwhash => params[:pwhash])
  return "Added user #{user.email}"
end

get '/user/check' do
  (not User.first(:email => params[:email], :pwhash => params[:pwhash]).nil?).to_s
end

