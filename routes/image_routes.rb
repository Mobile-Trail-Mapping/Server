get '/image/get/:point_id/:image_id/?' do |point_id, pic_id|
  point = Point.first(:id => point_id)

  return "Image does not exist" if point.nil?
  return "Image does not exist" if point.photos.size < pic_id.to_i

  string = Point.first(:id => point_id).photos[pic_id.to_i - 1].pic.url

  return "" if string.nil?

  file_path = string.split("?")[0]
  redirect file_path
end

get '/image/get/:point_id/?' do |point_id|
  point = Point.first(:id => point_id)
  return point.photos.size.to_i.to_s unless point.nil?
  return "0"
end

get '/image/upload/?' do
  haml :add_point
end

post '/image/add/?' do
  point_id = params[:id].to_i
  puts "point_id is #{point_id}"
  p = Point.first(:id => point_id)
  p.photos << Photo.new(:pic => make_paperclip_mash(params[:file]))
  p.save

  redirect "/image/get/#{point_id}"
end

get '/image/delete/?' do
  photo = Photo.first(:pic_file_name => params[:pic])
  photo.destroy unless photo.nil?
end
