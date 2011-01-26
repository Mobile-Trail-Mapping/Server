ENV['GEM_PATH'] = '/home/brousali/gems'

require 'rubygems'
require 'vendor/sinatra-1.0/lib/sinatra.rb'
require 'vendor/tilt-1.0/lib/tilt.rb'
require 'vendor/haml/lib/haml.rb'
require 'app'

set :run, false
set :environment, :production

run Sinatra::Application
