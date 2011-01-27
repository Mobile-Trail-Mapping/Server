ENV['GEM_PATH'] = '/home/brousali/gems'
ENV['GEM_HOME'] = '/home/brousali/gems'

require 'rubygems'
require 'sinatra'
require 'haml'

class Build
    attr_accessor :date, :branch, :ext, :version
    def initialize(date, branch, ext, version)
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
            array << Build.new(date, branch.chomp(ext), ext, "0")
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
    rescue
        @android = []
        @stable = []
    end
    p @stable
    Dir.chdir(@dir)
    haml :index
end
