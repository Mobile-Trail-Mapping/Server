require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'digest/sha1'
require 'builder'

configure do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://' + Dir.pwd + '/tmp/development.db') 
  xml = Builder::XmlMarkup.new
end

require 'models'

DataMapper.finalize
DataMapper.auto_upgrade!


