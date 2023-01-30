source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "devise"
gem "actionmailer", "~> 7.0"
gem "jsbundling-rails"
gem "sprockets-rails", "~> 3.4"
gem "turbo-rails", "~> 1.3"
gem "rails-i18n", "~> 7.0"
gem "devise-i18n", "~> 1.10"
gem "image_processing", ">= 1.2"
gem "dotenv-rails", "~> 2.8"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "capistrano", "~> 3.17"
  gem "capistrano-rails", "~> 1.6"
  gem "capistrano-passenger", "~> 0.2.1"
  gem "capistrano-rbenv", "~> 2.2"
  gem "capistrano-bundler", "~> 2.1"
end

group :production do
  gem "aws-sdk-s3", "~> 1.117"
end
