xml.instruct!
xml.problems do
  @problems.each do |prob|
    xml.problem do
      xml.id prob[:id]
      xml.title prob[:title]
      xml.desc prob[:desc]
      xml.user prob[:user]
      #xml.pic prob[:pic]
    end
  end
end
