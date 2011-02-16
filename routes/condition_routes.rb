# Add a new condition
post '/condition/add/?' do
  condition = Condition.first_or_create(:desc => params[:condition])

  redirect '/trails'
end

# Return a list of all conditions as xml
get '/condition/get/?' do
  @conditions = Condition.all
  builder :condition
end

# Delete a condition
get '/condition/delete/?' do
  condition = Condition.first(:desc => params[:condition])
  condition.destroy unless condition.nil?
end
