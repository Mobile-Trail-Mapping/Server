post '/problem/add/?' do
  desc = params[:desc]
  user = params[:user]
  title = params[:title]
  image = make_paperclip_mash(params[:pic])

  Problem.first_or_create(:desc => desc, :user => user, :pic => image, :title => title)
end

get '/problem/get/?' do
  @problems = Problem.all

  builder :problem
end
