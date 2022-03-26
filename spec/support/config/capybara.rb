require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV['NO_HEADLESS'].present?
      driven_by :selenium_chrome
    else
      driven_by :selenium_chrome_headless
    end
  end
end
