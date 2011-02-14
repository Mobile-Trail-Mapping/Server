# Return a specific image
get '/image/get/:point_id/:image_id/?' do |point_id, pic_id|
  point = Point.first(:id => point_id)

  return "Image does not exist" if point.nil?
  return "Image does not exist" if point.photos.size < pic_id.to_i

  string = Point.first(:id => point_id).photos[pic_id.to_i - 1].pic.url

  return "" if string.nil?

  file_path = string.split("?")[0]
  redirect file_path
end

# Return the number of images associated with a point
get '/image/get/:point_id/?' do |point_id|
  point = Point.first(:id => point_id)
  return point.photos.size.to_i.to_s unless point.nil?
  return "0"
end

# Basic page for uploading images
get '/image/upload/?' do
  haml :add_point
end

# Add a new image
post '/image/add/?' do
  point_id = params[:id].to_i
  p = Point.first(:id => point_id)
  p.photos << Photo.new(:pic => make_paperclip_mash(params[:file]))
  p.save

  redirect "/image/get/#{point_id}"
end

# Delete an image
get '/image/delete/?' do
  photo = Point.get(params[:point_id]).photos[params[:pic_id] - 1]
  photo.destroy unless photo.nil?
end
