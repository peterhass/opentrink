source 'https://rubygems.org'

ruby '3.2.3'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'puma', '>= 5.0'

gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'

gem 'bootsnap', require: false
gem 'simple_form', '~> 5.3.0'
gem 'rqrcode', '~> 2.0'
gem 'scenic', '~> 1.8'
gem 'scenic_sqlite_adapter', '~> 0.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri windows ]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
