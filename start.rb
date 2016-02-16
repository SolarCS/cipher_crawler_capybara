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

url = 'http://www.hardscrabble.net'

# Visit the root URL
browser.visit url

# Save page
browser.save_page

# Grab all the links on the page to click the last link to all the archives
browser.all('.posts a').last.click

# Save next page of all archives
browser.save_page

# Save new links in the posts variable
posts = browser.all '.posts li'

# Create a class to organize the individual posts
# class Post
#   attr_reader :title :link
#
#   def initialize(title, link)
#     @title = title
#     @link = link
#   end
# end

# Output title/links and store the Entry object in the entries array
# postsArray = []

posts.each do |post|
  puts "#{post.find('a')['href']}"
  puts post.find('span').text
  puts post.find('a').text, "\n"
  # postsArray << Post.new(title, link)
end
