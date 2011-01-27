require 'rubygems'

class Build
    attr_accessor :date, :branch
    def initialize(date, branch)
        @date = date
        @branch = branch
    end
end

@android = []
@iphone = []

def parseFolder(name)
    #MTMBeta_MM-DD-YYYY_BRANCH-NAME.apk
    array = []
    Dir.chdir(name)    
    Dir.glob("*") { |filename|
        file = filename.split("_")
        build = Build.new(file[1], file[2].chomp(File.extname(file[2])))
        array << build
    }
    return array
end

@android = parseFolder("android")
@iphone = parseFolder("iphone")