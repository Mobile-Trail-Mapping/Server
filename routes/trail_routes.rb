post '/trail/add' do
  trail = Trail.first_or_create(:name => params[:trail])
  "Added Trail #{trail.name}"
end

get '/trail/get' do
  content_type 'application/xml', :charset => 'utf-8'
  @trails = Trail.all
  builder :trail
end