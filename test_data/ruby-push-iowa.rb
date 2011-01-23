require 'pp'
require 'net/http'
require 'uri'

File.open('iowa.txt', 'r') do |in_file|
  count = 1
  points = [] 
  more_conns_ids = {}
  connections = {}

  while (line = in_file.gets)
    parts = line.split(" ").map { |part| part.chomp }

    if parts[0][0] == "*" || parts[0][0] == 42 #42 is *
      lat = parts[1]
      long = parts[2]

      if more_conns_ids.keys.include?(parts[0][1])
        connections[count] = more_conns_ids[parts[0][1]]
      else
        more_conns_ids[parts[0][1]] = count
      end
    else
      lat = parts[0]
      long = parts[1]
    end

    points << { :lat => lat, :long => long, :id => count, :connections => "#{count - 1 }"} if count > 1
    points << { :lat => lat, :long => long, :id => count, :connections => "" } if count == 1

    count += 1
  end

  connections.keys.each do |connection|
    points[connection][:connections] << ", #{connections[connection]}"
  end

  pp points

  points.each do |point|
    point[:desc] = "point"
    point[:category] = "Trail"
    point[:condition] = "Open"
    point[:trail] = "iowa"
    point[:title] = "title"
  end

  points.first[:category] = "Trailhead"
  points.first[:title] = "Sac and Fox Trailhead"
  points.first[:desc] = "The beginning of the trail."
  points.last[:category] = "Trailhead"
  points.last[:title] = "Sac and Fox Trailhead"
  points.last[:desc] = "The end of the trail."

  points.each do |point|
    Net::HTTP.post_form(URI.parse('http://localhost:4567/point/add'), point)
  end
end
