get '/point/get/?' do
  @trails = Trail.all - Trail.all(:name => 'misc') 
  @misc = Trail.all(:name => 'misc').points

  builder :point
end

post '/point/add/coords/?' do
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
  end

  point.save

  "Added Point #{point.lat}, #{point.long}"
end

post '/point/add/?' do
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
  end

  point.save

  "Added Point #{point.lat}, #{point.long}"
end

