post '/trail/add/?' do
  trail = Trail.first_or_create(:name => params[:trail])
  "Added Trail #{trail.name}"
end

get '/trail/get/?' do
  @trails = Trail.all
  builder :trail
end

get '/trail/delete/?' do
  trail = Trail.all(:name => params[:trail])
  trail.destroy unless trail.nil?
end
