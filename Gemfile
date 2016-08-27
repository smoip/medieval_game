source 'https://rubygems.org'

gem 'activesupport'

group :development, :test do
  gem 'pry-byebug', :require => false
  gem 'rubocop', :require => false
  gem 'byebug', :require => false
  gem 'factory_girl'

  gem 'autotest-standalone'
  gem 'autotest-growl'
  gem 'autotest-fsevent' if RUBY_PLATFORM =~ /darwin/i
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
end

group :test do
  gem 'rspec'
end
