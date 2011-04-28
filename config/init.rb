require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-paperclip'
require 'digest/sha1'
require 'builder'
require 'haml'
require 'json'

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://' + Dir.pwd + '/tmp/development.db') 
end

require 'models'

DataMapper.finalize
DataMapper.auto_upgrade!


