# == Schema Information

# Table: scrappings

# id													:bigint
# scrapped_at: 								:datatime
# book_quantity: 							:integer
# vocabulary_quantity: 				:integer
# status: 										:integer
# created_at: 								:datatime
# updated_at: 								:datatime

class Scrapping < ApplicationRecord
	include AASM
	
	enum status: {
		proccessing: 0,
		done: 1,
		faild: 2
	}

	enum status: {
		not_yet:0,
		processing: 1,
		completed: 2,
		failed: 3
	}

	# aasm column: :status enum: true do
  #   state :not_yet, :initial => true
  #   state :processing,
  #   state :completed,
  #   state :failed,

  #   # 未承認＝＞承認中
  #   event :check do
  #     transitions :from => :unapproved, :to => :pending
  #   end

  #   # 承認中＝＞承認済
  #   event :approve do
  #     transitions :from => :pending, :to => :approved
  #   end

  #   # 承認中＝＞未承認
  #   event :remand do
  #     transitions :from => :pending, :to => :unapproved
  #   end

  #   # 承認中＝＞却下
  #   event :reject do
  #     transitions :from => :pending, :to => :rejection
  #   end
  # end


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
