source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'mongoid'
gem 'bson_ext'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end # group assets

gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl'
  gem 'database_cleaner'
  
  path '../rspec-sleeping_king_studios' do
    gem 'rspec-sleeping_king_studios'
  end # path
end # group
