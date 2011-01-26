task :default => :dev

desc 'rsync the contents of site to the server'
task :sync do
  puts '* Publishing files to live server'
  puts `rsync -e ssh -avz . brousali@brousalis.com:public_html/builds`
end

desc 'Push source code to Github'
task :push do
  puts '* Pushing to Github'
  puts `git add .`
  puts `git commit -m "#{ENV['m']}" .`
  puts `git push`
end

desc 'Touch txt'
task :touch do
  puts '* Restarting Passenger'
  puts `touch tmp/restart.txt`
end

desc 'Publish and sync'
  task :p => [:sync, :push, :touch] do
end