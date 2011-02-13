post '/condition/add/?' do
  condition = Condition.first_or_create(:desc => params[:condition])
  "Added Condition #{condition.desc}"
end

get '/condition/get/?' do
  @conditions = Condition.all
  builder :condition
end

get '/condition/delete/?' do
  condition = Condition.first(:desc => params[:condition])
  condition.destroy unless condition.nil?
end
