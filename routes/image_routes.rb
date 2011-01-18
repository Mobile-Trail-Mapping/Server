require 'pp'

get '/image/get/:point_id/:image_id' do |point_id, pic_id|
  #image_id is 1 based
  #send_file("images/#{point_id}/#{pic_id}.jpg")
  #send_file(Point.first(:id => point_id).photos[pic_id - 1])
  send_file(Point.first(:id => point_id).photo.url)
end

get '/image/get/:point_id' do |point_id|
  point = Point.first(:id => point_id)
  return point.photos.size.to_i.to_s unless point.nil?
  return "0"
end

get '/image/upload' do 
  haml :add_point
end

post '/image/add/:point_id' do |point_id|
  p = Point.first(:id => point_id)
  p.photo = make_paperclip_mash(params[:file])
  p.save
end
