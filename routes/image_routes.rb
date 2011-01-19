require 'pp'

get '/image/get/:point_id/:image_id' do |point_id, pic_id|
  string = Point.first(:id => point_id).photos[pic_id.to_i - 1].pic.url
  file_path = string.split("?")[0]
  redirect file_path
end

get '/image/get/:point_id' do |point_id|
  point = Point.first(:id => point_id)
  return point.photos.size.to_i.to_s unless point.nil?
  return "0"
end

get '/image/upload' do 
  haml :add_point
end

post '/image/add' do
  point_id = params[:id].to_i
  puts "point_id is #{point_id}"
  p = Point.first(:id => point_id)
  p.photos << Photo.new(:pic => make_paperclip_mash(params[:file]))
  p.save
end
