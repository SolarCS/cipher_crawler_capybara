# Require the gems
require 'capybara/poltergeist'
require 'pry'
require 'pry-nav'
# Configure Capybara to use Poltergeist as the driver
Capybara.default_driver = :poltergeist

# Configure Poltergeist to handle javascript erorrs gracefully.
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

# Instantiate a new browser instance
browser = Capybara.current_session

url = 'http://ngauthier.com/'

# Visit the root URL
browser.visit url

# Save page
browser.save_page

all_links = browser.all('a')

links_hash = {}

all_links.each do |link|
  if link['href'].include? browser.current_url
    links_hash[link['href']] = ""
  end
end
puts links_hash
# binding.pry
