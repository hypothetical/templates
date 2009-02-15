gem 'RedCloth', :lib => 'redcloth'
gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
# gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com'
gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com'
gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com'
gem 'haml'

rake "gems:install"
plugin 'footnotes', :git => 'git://github.com/josevalim/rails-footnotes.git'
run 'touch test/factory.rb'

capify!

inside 'config/deploy' do
  run 'touch production.rb'
  run 'touch staging.rb'
end
run 'cp config/environments/production.rb config/environments/staging.rb'

git :init

file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

git :add => '.', :commit => "-m 'initial commit'"