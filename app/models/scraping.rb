# == Schema Information

# Table: scrapings

# id													:bigint
# vocabulary_quantity: 				:integer
# status:                     :integer
# book_id:                     :integer
# created_at: 								:datatime
# updated_at: 								:datatime

class Scraping < ApplicationRecord
  belongs_to :book

  enum status: {
    proccessing: 0,
    done: 1,
    failed: 2
  }

  def self.driver_access
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument("--no-sandbox")
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--remote-debugging-port=9222')

    Selenium::WebDriver.for :chrome, options: options
  end
end
