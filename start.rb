# Require the gems
require 'capybara/poltergeist'

# Configure Capybara to use Poltergeist as the driver
Capybara.default_driver = :poltergeist

# Configure Poltergeist to handle javascript erorrs gracefully.
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

# Instantiate a new browser instance
browser = Capybara.current_session

# Visit the root URL
browser.visit 'http://www.hardscrabble.net'
