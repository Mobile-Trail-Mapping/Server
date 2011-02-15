task :default => :dev

#desc 'rsync the contents of site to the server'
#task :sync do
#  puts '* Publishing files to live server'
#  puts `rsync -e ssh -avz --exclude-from '.gitignore' --exclude '.git/' . brousali@brousalis.com:public_html/builds`
#end

desc 'Push source code to Github'
task :push do
  puts '* Pushing to Github'
  puts `git add .`
  puts `git commit -m "#{ENV['m']}" .`
end

desc "Deploy to Heroku."
task :deploy do
   require 'heroku'
   require 'heroku/command'
   user, pass = File.read(File.expand_path("~/.heroku/credentials")).split("\n")
   heroku = Heroku::Client.new(user, pass)

   cmd = Heroku::Command::BaseWithApp.new([])
   remotes = cmd.git_remotes(File.dirname(__FILE__) + "/../..")

   remote, app = remotes.detect {|key, value| value == (ENV['APP'] || cmd.app)}

   if remote.nil?
   raise "Could not find a git remote for the '#{ENV['APP']}' app"
   end

   `git push #{remote} test:master`

   heroku.restart(app)
end

desc 'Publish and sync'
  task :p => [:push, :deploy] do
end