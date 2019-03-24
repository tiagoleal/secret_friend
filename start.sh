# Install the Gems
bundle check || bundle install
# Run our server
bundle exec puma -C config/puma.rb