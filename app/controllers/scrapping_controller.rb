class ScrappingController < ApplicationController
  def index
    @last_scrapping = Scrapping.all.last
    @present_date = I18n.l(Date.today)
  end

  def show; end

  def new
    ScrapeVocab.perform_later
  end

  def create; end
end
