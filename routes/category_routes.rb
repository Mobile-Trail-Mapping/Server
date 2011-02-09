post '/category/add/?' do
  category = Category.first_or_create(:name => params[:category])
  "Added Category #{category.name}"
end

get '/category/get' do
  content_type 'application/xml', :charset => 'utf-8'
  @categories = Category.all
  builder :category
end
