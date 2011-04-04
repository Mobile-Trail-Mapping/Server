# Add a new trail
post '/trail/add/?' do
  trail = Trail.first_or_create(:name => params[:trail])
  redirect '/trails'
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
  @trails.each { |trail| @photos[trail.name] = [] }
  @trails.points.each do |point|
    point.photos.each do |photo|
      @photos[point.trail.name] << photo
    end
  end

  haml :trails
end

get '/trails/get/:trail/?' do
  content_type :json
  @json = {}
  @trail = Trail.first(:name => params[:trail])
  @trail.points.each do |point|
    @json[point.id] = { :lat => point[:lat], :long => point[:long], :desc => point[:desc] }
    @json[point.id][:photos] = point.photos
  end

  @json.to_json
end

get '/trails/:trail/?' do
  @trail = Trail.first(:name => params[:trail])
  @images = []
  @trail.points.each do |point|
    point.photos.each { |photo| @images << photo }
  end
  haml :trail
end

get '/trail/add/?' do
  haml :add_trail
end
