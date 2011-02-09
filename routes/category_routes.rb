post '/category/add/?' do
  category = Category.first_or_create(:name => params[:category])
  "Added Category #{category.name}"
end

get '/category/get/?' do
  @categories = Category.all

  builder :category
end
