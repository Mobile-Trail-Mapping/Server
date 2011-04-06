# Add a new problem
post '/problem/add/?' do
  desc = params[:desc].to_s
  user = params[:user].to_s
  title = params[:title].to_s
  lat = params[:lat].to_f
  long = params[:long].to_f
  image = make_paperclip_mash(params[:file])

  Problem.create(:desc => desc, :user => user, :pic => image, :title => title, :lat => lat, :long => long)

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

get '/problems/get/:id/?' do
  content_type :json

  @json = {}
  problem = Problem.get(params[:id].to_i)
  @json[:problem] = { :pic => problem[:pic_file_name], :lat => problem[:lat], :long => problem[:long], :desc => problem[:desc], :title => problem[:title] }

  @json.to_json
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