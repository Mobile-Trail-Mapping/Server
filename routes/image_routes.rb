require 'pp'

get '/image/get/:point_id/:image_id' do |point_id, pic_id|
  #image_id is 1 based
  string = Point.first(:id => point_id).photo.url
  send_file(string[1, string.length].split("?")[0])
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
  p.photo = make_paperclip_mash(params[:file])
  p.save
end
