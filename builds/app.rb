ENV['GEM_PATH'] = "#{ENV['HOME']}/ruby/gems:/usr/lib/ruby/gems/1.8"

require 'rubygems'
require 'sinatra'

get '/' do
  "Test"
end