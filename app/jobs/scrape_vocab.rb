class ScrapeVocab < ApplicationJob
  require 'selenium-webdriver'

  queue_as :default

  def perform(*_args)

    driver = Scrapping.driver_access
    driver.manage.timeouts.implicit_wait = 10

    driver.navigate.to ENV['KINDLE_NOTEBOOK_URL']
    sleep 5

		p 'enter login procces'
    login_kindle(driver)

		p 'select books'
		select_eng_books(driver)
    p ' yo'



		driver.quit
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
		sleep 20
		p 'done login'
  end

	def select_eng_books(driver)
		sleep 1
		p 'nonono'
		book_titles_area = driver.find_elements(:class_name, 'kp-notebook-library-each-book')

		book_titles = Array.new
		sleep 1
		book_quantity = book_titles_area.size

		p "#{book_quantity} start seraching book title"

		book_quantity.times do |timesCount|
			sleep 1
			p "#{timesCount} try book title"
			book_titles_area[timesCount].click
			# 長めに取るor何か違う方法で対応
			sleep 20
			book_title = driver.find_element(:css, 'h3.a-spacing-top-small').text
			author = driver.find_element(:css, 'p.a-spacing-top-micro').text
			if book_title.match(/\A[ -~]+\z/)
				# ここで英語の本と判断できれば、もう単語のスクレイピング始めてもいいかも･
				book_titles.push(book_title)
				p 'create book'
				Book.create(title: book_title, author: author) unless Book.find_by(title: book_title)
				# 一番最後の保存されている単語とkindleの単語見て、新しくあれば単語のスクレイプする。
				sleep 1
				p 'getting hightlights'
				# ハイライトをすべて取得
				hightlights = driver.find_elements(:css, 'div.kp-notebook-print-override')
				sleep 1
				collect_and_select_vocab(hightlights)
				# 単語一つの場合→コンマなど除去する、その後wordに保存
				# センテンスの場合、センテンスをexampleに保存、memoをwordに保存

			end
		end

		# book_titles.each do |book_title|
		# 	p "#{book_title} was selected"
		# end
	end

	def collect_and_select_vocab(hightlights)
		p 'start collect_and_select_vocab'
		hightlights.each do |hightlight|
			sleep 1
			hightlight_and_note = hightlight.find_elements(:class_name, 'kp-notebook-highlight-yellow')
			# ハイライトが確実にある場合
			p "#{hightlight_and_note.size}"
			unless hightlight_and_note.size == 0
				yellow_hightlight = hightlight.find_element(:class_name, 'kp-notebook-highlight-yellow').text
				p "done hightlight:#{yellow_hightlight}"
				# 文であれば登録しないなど、、
				p "done hightlight:#{count_words(yellow_hightlight)}"
				if count_words(yellow_hightlight) <= 1
					Vocabulary.create!(
						word: yellow_hightlight
					)
				end
				note = hightlight.find_element(:id, 'note').text
				p "done note:#{note}"
			end
		end
	end

	def count_words(str)
		ary = str.split
		ary.size
	end
end
