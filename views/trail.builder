xml.instruct!
xml.trails do
  @trails.each do |trail|
    xml.trail do
      xml.id trail[:id]
      xml.name trail[:name]
    end
  end
end
