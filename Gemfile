source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'mysql2'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'

gem 'devise'
gem 'cancancan'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'grape'
gem 'grape-cancan'
gem 'grape-entity'

group :development, :test do
  gem 'pry-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false

  gem 'capybara'
  gem 'capybara-webkit'

  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
