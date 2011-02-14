# Add a new problem
post '/problem/add/?' do
  desc = params[:desc]
  user = params[:user]
  title = params[:title]
  image = make_paperclip_mash(params[:pic])

  Problem.first_or_create(:desc => desc, :user => user, :pic => image, :title => title)
end

# Return a list of problems as xml
get '/problem/get/?' do
  @problems = Problem.all
  builder :problem
end

# Delete a problem
get '/problem/delete/?' do
  problem = Problem.all(:id => parmas[:id])
  problem.destroy unless problem.nil?
end
