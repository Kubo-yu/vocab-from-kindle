class ScrapeVocab < ApplicationJob
  require 'selenium-webdriver'

  queue_as :default

  def perform(*_args)
    wait = Selenium::WebDriver::Wait.new(timeout: 60)

    driver = Scrapping.driver_access
    driver.manage.timeouts.implicit_wait = 10

    driver.navigate.to ENV['KINDLE_NOTEBOOK_URL']
    sleep 10

    login_kindle(driver)

    p ' yo'
  end

  # メール、パスワード入力してログイン
  def login_kindle(driver, wait)
    # ログインボタンが表示されるまで待機
    wait.until { driver.find_element(:id, 'signInSubmit').displayed? }

    email_input = driver.find_element(:id, 'ap_email')
    pass_input = driver.find_element(:id, 'ap_password')

    email_input.send_keys(ENV['KINDLE_NOTEBOOK_USER'])
    pass_input.send_keys(ENV['KINDLE_NOTEBOOK_PASS'])

    driver.find_element(:id, 'signInSubmit').click
  end
end
