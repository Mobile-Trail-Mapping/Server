# Add a new problem
post '/problem/add/?' do
  desc = params[:desc]
  user = params[:user]
  title = params[:title]
  lat = params[:lat].to_f
  long = params[:long].to_f
  image = make_paperclip_mash(params[:file])

  Problem.create(:desc => desc, :user => user, :pic => image, :title => title, :lat => lat, :long => long)
end

get '/problem/add/?' do
  haml :add_problem
end

# Return a list of problems as xml
get '/problem/get/?' do
  @problems = Problem.all
  builder :problem
end

get '/problems/?' do
  @problems = Problem.all
  haml :problem
end

# Delete a problem
get '/problem/delete/?' do
  problem = Problem.all(:id => parmas[:id])
  problem.destroy unless problem.nil?
end
