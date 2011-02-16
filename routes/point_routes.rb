# Return a list of all points as xml
get '/point/get/?' do
  @trails = Trail.all - Trail.all(:name => 'misc') 
  @misc = Trail.all(:name => 'misc').points

  builder :point
end

# Add a new point with connections specified as lat and long
post '/point/add/coords/?' do
  params[:desc] = " " if params[:desc] == ""
  params[:title] = " " if params[:title] == ""
  params[:category] = "Trail" if params[:category] == ""
  params[:trail] = "Misc" if params[:trail] == ""
  params[:condition] ||= "Open"
  params[:condition] = "Open" if params[:condition] == ""

  point = Point.first_or_create(:lat => params[:lat], :long => params[:long], :desc => params[:desc], :title => params[:title])

  #not sure why you have to set these to variables first, but you do
  cat = Category.first_or_create(:name => params[:category])
  cond = Condition.first_or_create(:desc => params[:condition])
  trail = Trail.first_or_create(:name => params[:trail])
  point.category = cat
  point.condition = cond
  point.trail = trail

  params[:connections].split(',').each do |conn|
    conn.split(":").each do |lat, long|
      lat, long = lat.to_i, long.to_i
      p = Point.first_or_create(:lat.lte => lat + 0.0005, :lat.gte => lat - 0.0005, :long.lte => long + 0.0005, :long.gte => long - 0.0005)
      point.connections << Connection.first_or_create(:connected_to => p.id.to_i, :connected_from => point.id)
    end
  end unless params[:connections].nil?

  point.save

  "#{point.id}"
end

get '/point/add/?' do
  haml :add_point
end

# Add a new point with connections specified as point id's
post '/point/add/?' do
  params[:desc] = " " if params[:desc] == ""
  params[:title] = " " if params[:title] == ""
  params[:category] = "Trail" if params[:category] == ""
  params[:trail] = "Misc" if params[:trail] == ""
  params[:condition] ||= "Open"
  params[:condition] = "Open" if params[:condition] == ""

  point = Point.first_or_create(:lat => params[:lat], :long => params[:long], :desc => params[:desc], :title => params[:title])


  #not sure why you have to set these to variables first, but you do
  cat = Category.first_or_create(:name => params[:category])
  cond = Condition.first_or_create(:desc => params[:condition])
  trail = Trail.first_or_create(:name => params[:trail])
  point.category = cat
  point.condition = cond
  point.trail = trail

  point.save

  params[:connections].split(',').each do |conn|
    point.connections << Connection.first_or_create(:connected_to => conn.to_i, :connected_from => point.id)
  end unless params[:connections].nil?

  point.save

  "#{point.id}"
end

# Delete a point
get '/point/delete/:id/?' do
  point = Point.all(:id => params[:id])
  point.destroy unless point.nil?
end

post '/point/update/?' do
  point = Point.get(params[:id].to_i)

  params.delete("id")
  params.delete("user")
  params.delete("pwhash")
  params.delete("connections")

  params["category"] = Category.first_or_create(:name => params[:category]) unless params[:category].nil?
  params["condition"] = Condition.first_or_create(:desc => params[:condition]) unless params[:condition].nil?
  params["trail"] = Trail.first_or_create(:name => params[:trail]) unless params[:trail].nil?

  point.update(params)

  point.save
  
  redirect "/trails"
end

get '/point/update/:id/?' do
  @point = Point.get(params[:id].to_i)
  haml :edit_point
end
