ENV['GEM_PATH'] = '/home/brousali/gems'
ENV['GEM_HOME'] = '/home/brousali/gems'

require 'rubygems'
require 'sinatra'
require 'haml'

get '/' do
  "Last test of the rakefile"
end
