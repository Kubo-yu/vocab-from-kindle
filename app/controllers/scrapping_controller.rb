class ScrappingController < ApplicationController
  def index
    @last_scrapping = Scrapping.all.last
    @present_date = I18n.l(Date.today)
  end

  def show; end

  def new
		@scrapping = Scrapping.new
		@book = Book.new
		@vocabulary = Vocabulary.new
		# performのリターンをnewのviewで表示して、それをcreateアクションに送る
		# BookとVocabularyは繰り返し処理でsaveする
		ScrapeVocab.perform_later

  end

  def create
		@scrapping = Scrapping.new(post_params)

	end
end
