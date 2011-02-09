task :default => :dev

#desc 'rsync the contents of site to the server'
#task :sync do
#  puts '* Publishing files to live server'
#  puts `rsync -e ssh -avz --exclude-from '.gitignore' --exclude '.git/' . brousali@brousalis.com:public_html/builds`
#end

desc 'Push source code to Github'
task :p do
  puts '* Pushing to Github'
  puts `git add .`
  puts `git commit -m "#{ENV['m']}" .`
  puts `git push`
end

#desc 'Publish and sync'
#  task :p => [:push, :sync, :touch] do
#end