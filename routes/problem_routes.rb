post '/problem/add/?' do
  desc = params[:desc]
  user = params[:user]
  image = make_paperclip_mash(params[:pic])

  Problem.first_or_create(:desc => desc, :user => user, :pic => image)
end
