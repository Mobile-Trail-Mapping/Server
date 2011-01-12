get '/image/get/:point_id/:image_id' do |point_id, pic_id|
  #image_id is 1 based
  return "<img src=images/#{point_id}/#{pic_id}.jpg />"
end

get '/image/get/:point_id' do |point_id|
  return Point.first(:id => point_id).photos.size.to_i.to_s
end
