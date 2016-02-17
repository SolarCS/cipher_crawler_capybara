#!/usr/bin/env ruby

# Require the gems
require 'capybara/poltergeist'
require 'awesome_print'

# Configure Capybara to use Poltergeist as the driver
Capybara.default_driver = :poltergeist

# Configure Poltergeist to handle javascript erorrs gracefully.
# See more options at https://github.com/teampoltergeist/poltergeist#customization
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

# Instantiate a new browser instance
browser = Capybara.current_session

url = "http://www.hardscrabble.net/"

# Visit the root URL
browser.visit url

# Save page
browser.save_page

links_hash = {}

root_links = browser.all('a')
root_links = root_links.collect{|a|a['href']}
root_links.uniq.each do |page2|
  if page2.include? url
    browser.visit page2
    browser.save_page
    links2 = browser.all('a')
    links2 = links2.collect{|a|a['href']}
    arr = []
    links2.uniq.each do |page3|
      if page3.include? url
        arr.push(page3)
        links_hash[browser.current_url] = arr
      end
    end
  end
end

File.open("results.txt", "w") do|somefile|
  somefile.write(links_hash.awesome_inspect)
end
