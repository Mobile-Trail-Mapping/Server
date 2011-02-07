require 'rubygems'
require 'sinatra'
require 'config/init'
require 'pp'
Dir['routes/*'].each { |obj| require obj }

configure do
  OBJECTS = ['user', 'point', 'trail', 'condition', 'category']
  User.first_or_create(:email => 'test@brousalis.com', :pwhash => Digest::SHA1.hexdigest('password'))
  Trail.first_or_create(:name => 'misc')
end

before do
  OBJECTS.each do |object|
    if request.path_info.split('/').include?(object) && not request.path_info.split('/').include?("get")
      halt "Invalid username or password" if password_matches_user?(params[:user], params[:pwhash])
    end
  end
end

helpers do
  def password_matches_user?(user, pass)
    User.all(:email => user, :pwhash => pass).empty?
  end

  def make_paperclip_mash(file_hash)
    mash = Mash.new
    mash['tempfile'] = file_hash[:tempfile]
    mash['filename'] = file_hash[:filename]
    mash['content_type'] = file_hash[:type]
    mash['size'] = file_hash[:tempfile].size
    mash
  end
end

get '/' do
  "Welcome to mobile trail mapping application"
end


