source 'https://rubygems.org'

gem 'chef', '>=11.0'
gem 'rake'
gem 'berkshelf'

group :test do
  gem "foodcritic", "~> 3.0.3"
  gem "strainer"
  gem "rubocop"
end

group :integration do
  gem 'test-kitchen'
  gem "kitchen-vagrant"
  gem 'kitchen-docker'
end
