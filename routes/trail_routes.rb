# Add a new trail
post '/trail/add/?' do
  trail = Trail.first_or_create(:name => params[:trail])
  "Added Trail #{trail.name}"
end

# Return a list of trails as xml
get '/trail/get/?' do
  @trails = Trail.all
  builder :trail
end

# Delete a trail
get '/trail/delete/?' do
  trail = Trail.all(:name => params[:trail])
  trail.destroy unless trail.nil?
end

get '/trails/?' do
  @trails = Trail.all
  @photos = Hash.new
  @trails.points.each do |point|
    point.photos.each { |photo| @photos[point.trail.name] << photo }
  end
  haml :trails
end

get '/trails/:trail/?' do
  @trail = Trail.first(:name => params[:trail])
  haml :trail
end
