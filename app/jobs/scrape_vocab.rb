class ScrapeVocab < ApplicationJob
  require 'selenium-webdriver'

  queue_as :default
  sidekiq_options retry: false

  def perform(book_id)
    # scraping = Scraping.create!(status: 0, book_id: book_id)
    puts '2'
    vocabularies = Vocabulary.where(book_id: book_id, definition: [nil, ''])
    max_one_session = 39
    puts '3'
    vocabularies.each.with_index do |vocabulary, index|
      driver = driver_access
      puts '3.5'
      driver.manage.timeouts.implicit_wait = 30
      driver.navigate.to ENV['WEBLIO_URL']
      sleep 2
      puts '4'
      puts "start #{vocabulary}"
      search(driver, vocabulary)
      sleep 2
      definition, phonics = get_definition_and_phonics(driver, vocabulary)
      puts "done #{vocabulary}"
      sleep 2
      driver.close
      driver.quit
      vocabulary.update!(definition: definition, phonics: phonics)
      break if index == max_one_session
    rescue StandardError => e
      logger.debug("スクレイピング時エラー: #{e}")
    end
    puts 'done!'
  end

  private

  def search(driver, vocabulary)
    puts "5 #{vocabulary.word}"
    search_button = driver.find_element(:class_name, 'formButton')
    word_input = driver.find_element(:class_name, 'formBoxITxt')
    word = vocabulary.word
    puts "6 #{word}"
    word_input.send_keys(word)
    sleep 1
    search_button.click
    sleep 1
  end

  def get_definition_and_phonics(driver, vocabulary)
    sleep 1
    puts "7 #{vocabulary.word}"
    definition = if driver.find_elements(:css, '.content-explanation.ej').empty?
                   'not found'
                 else
                   puts "7.5 #{vocabulary.word}"
                   driver.find_element(:css, '.content-explanation.ej').text
                 end
    sleep 1
    puts "8 #{definition}"
    phonics = if driver.find_elements(:class_name, 'phoneticEjjeDesc').empty?
                'not found'
              else
                puts "8.5 #{vocabulary.word}"
                driver.find_element(:class_name, 'phoneticEjjeDesc').text
              end
    puts "9 #{phonics}"
    [definition, phonics]
  end

  def driver_access
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument("--no-sandbox")
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--remote-debugging-port=9222')
    options.add_argument('--window-size=800,500')
    options.add_argument('--disable-extensions')
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-web-security')
    options.add_argument('--disable-desktop-notifications')
    options.add_argument('--blink-settings=imagesEnabled=false')
    options.add_argument('--proxy-server="direct://"')
    options.add_argument('--proxy-bypass-list=*')

    Selenium::WebDriver.for :chrome, options: options
  end
end
