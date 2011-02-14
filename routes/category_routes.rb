# Add a new category
post '/category/add/?' do
  category = Category.first_or_create(:name => params[:category])
  "Added Category #{category.name}"
end

# Return list of all categories as xml
get '/category/get/?' do
  @categories = Category.all
  builder :category
end

# Delete a category
get '/category/delete/?' do
  category = Category.first(:name => params[:category])
  category.destroy unless category.nil?
end
