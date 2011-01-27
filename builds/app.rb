require 'rubygems'
require 'sinatra'
require 'haml'

class Build
    attr_accessor :date, :branch
    def initialize(date, branch)
        @date = date
        @branch = branch
    end
end

def parseFolder(name)
    array = []
    Dir.chdir(name)    
    Dir.glob("*") { |filename|
        file = filename.split("_")
        array << Build.new(file[1].gsub("-","\/"), file[2].chomp(File.extname(file[2])))
    }
    return array
end

get '/' do
    @dir = Dir.getwd
    begin
        @android = parseFolder("android")
        #@iphone = parseFolder("iphone")
    rescue
        @android = []
        #@iphone = []
    end
    Dir.chdir(@dir)
    haml :index
end
