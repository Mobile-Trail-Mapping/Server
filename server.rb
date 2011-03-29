require 'rubygems'
require 'sinatra'
require 'json'
require 'config/init'
require 'pp'
Dir['routes/*'].each { |obj| require obj }

configure do
  enable :sessions
  OBJECTS = ['user', 'point', 'trail', 'condition', 'category', 'image', 'problems']

  #create a default user so we're not locked out
  User.first_or_create(:email => 'test@brousalis.com', :pwhash => Digest::SHA1.hexdigest('password'))
  Trail.first_or_create(:name => 'misc')
  
  #default server dir
  @serverdir = Dir.pwd
end

before do
  #validate user info before letting them post to the server
  OBJECTS.each do |object|
    if request.path_info.split('/').include?(object) && (not request.path_info.split('/').include?("get")) && (not request.path_info == '/user/login')
      #halt "Invalid username or password" if password_doesnt_match_user?(params[:user], params[:pwhash])
    end
  end
end

helpers do
  #Check user credentials
  def password_doesnt_match_user?(user, pass)
    User.all(:email => user, :pwhash => pass).empty? && User.all(:email => session[:user], :pwhash => session[:pwhash]).empty?
  end

  #Method for getting image hash
  def make_paperclip_mash(file_hash)
    mash = Mash.new
    mash['tempfile'] = file_hash[:tempfile]
    mash['filename'] = "#{Time.now.to_s}.jpg"
    mash['content_type'] = file_hash[:type]
    mash['size'] = file_hash[:tempfile].size
    mash
  end
end

#show homepage
get '/' do
  haml :index, {:layout => :login}
end

#show dashboard
get '/dashboard' do
  haml :dashboard
end
