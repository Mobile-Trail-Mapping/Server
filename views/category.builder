xml.instruct!
xml.categories do
  @categories.each do |cat|
    xml.category do
      xml.name cat[:name]
    end
  end
end
