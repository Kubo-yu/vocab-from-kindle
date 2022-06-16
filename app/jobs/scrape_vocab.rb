class ScrapeVocab < ApplicationJob
  require 'selenium-webdriver'

  queue_as :default

  def perform(book_id)
    ApplicationRecord.transaction do
      puts '1'
      scraping = Scraping.create!(status: 0, book_id: book_id)
      puts '2'
      vocabularies = Vocabulary.where(book_id: book_id, definition: nil)
      puts '3'
      driver = Scraping.driver_access
      driver.manage.timeouts.implicit_wait = 10
      driver.navigate.to ENV['WEBLIO_URL']
      puts 'set window size'
      driver.manage.window.resize_to(800, 500)
      sleep 10
      puts '4'
      vocabularies.each do |vocabulary|
        puts "start #{vocabulary}"
        search(driver, vocabulary)
        sleep 3
        definition, phonics = get_definition_and_phonics(driver, vocabulary)
        vocabulary.update!(definition: definition, phonics: phonics, scraping_id: scraping.id)
        puts "done #{vocabulary}"
      end
      puts '10'
      scraping.update!(status: 1)
      puts 'done!'
    end
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
                   puts "8.5 #{vocabulary.word}"
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
    claer_input(driver)
    [definition, phonics]
  end

  def claer_input(driver)
    driver.find_element(:class_name, 'formBoxITxt').clear
  end
end
