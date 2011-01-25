ENV['GEM_PATH'] = "#{ENV['HOME']}/ruby/gems:/usr/lib/ruby/gems/1.8"
ENV['GEM_HOME'] = "#{ENV['HOME']}/ruby/gems"

require 'rubygems'
require 'sinatra'
require 'app'

run Sinatra::Application