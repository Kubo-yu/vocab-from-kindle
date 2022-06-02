class ScrapeVocab < ApplicationJob
  require 'selenium-webdriver'

  queue_as :default

  def perform(*_args)
    driver = Scrapping.driver_access
    driver.manage.timeouts.implicit_wait = 10

    driver.navigate.to ENV['KINDLE_NOTEBOOK_URL']
    sleep 5

		p 'enter login procces'
    logined_driver = login_kindle(driver)

		sleep 10

		p 'select books'
		select_eng_books(driver)
    p ' yo'

		driver.quit3
  end

  # メール、パスワード入力してログイン
  def login_kindle(driver)
		p 'find login input'
    email_input = driver.find_element(:id, 'ap_email')
    pass_input = driver.find_element(:id, 'ap_password')

		sleep 1

		p 'send login info'
    email_input.send_keys(ENV['KINDLE_NOTEBOOK_USER'])
    pass_input.send_keys(ENV['KINDLE_NOTEBOOK_PASS'])

		sleep 1
		p 'click login'
    driver.find_element(:id, 'signInSubmit').click

		p 'done login'
  end

	def select_eng_books(driver)

		sleep 1
		p 'nonono'
		book_titles_area = driver.find_elements(:class, 'kp-notebook-library-each-book')


		book_titles[]
		sleep 1
		book_quantity = book_titles.count

		book_quantity.times do |timesCount|
			p "#{timesCount} try book title"
			driver.book_titles[timesCount].click
			book_title = driver.find_element(:css, 'h3.a-spacing-top-small').text
			if book_title.match(/\A[ -~]+\z/)
				# ここで英語の本と判断できれば、もう単語のスクレイピング始めてもいいかも･
				book_titles.push(book_title)
			end
		end

		return book_titles
		# end
	end
end
