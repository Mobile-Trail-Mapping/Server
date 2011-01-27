ENV['GEM_PATH'] = '/home/brousali/gems'
ENV['GEM_HOME'] = '/home/brousali/gems'

require 'rubygems'
require 'sinatra'
require 'haml'

class Build
    attr_accessor :date, :branch, :ext, :version
    def initialize(date, branch, ext, version=0)
        @date = date
        @branch = branch
        @ext = ext
        @version = version
    end
end

def parseBuilds(name)
    array = []
    Dir.chdir(name) 
    Dir.glob("*") { |filename|
        file = filename.split("_")
        date = file[1].gsub("-","\/")
        branch = file[2]
        ext = File.extname(filename)
        if name != "stable"
            array << Build.new(date, branch.chomp(ext), ext)
        else
            array << Build.new(date, branch, ext, file[3].chomp(ext))
        end
    }
    Dir.chdir("../")
    return array
end

get '/' do
    @dir = Dir.getwd
    begin
        @stable = parseBuilds("stable")
        @android = parseBuilds("android")
        @iphone = parseBuilds("iphone")
    rescue
        @android = []
        @stable = []
        @iphone = []
    end
    Dir.chdir(@dir)
    haml :index
end
