# Add a new problem
post '/problem/add/?' do
  params[:file] = make_paperclip_mash(params[:file])
  params_clone = params.clone
  params = default_values(request.path_info, params_clone)

  #Problem.create(:desc => desc, :user => user, :pic => image, :title => title, :lat => lat, :long => long)
  Problem.create(params)

  redirect '/problems'
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
get '/problem/delete/:id/?' do
  problem = Problem.all(:id => params[:id])
  problem.destroy unless problem.nil?
  redirect "/problems"
end

post '/problem/delete/:id/?' do
  problem = Problem.all(:id => params[:id])
  problem.destroy unless problem.nil?
  redirect "/problems"
end
