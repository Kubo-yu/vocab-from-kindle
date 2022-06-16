class ScrapingsController < ApplicationController
  def index
    @scrapings = Scraping.all
    @present_date = I18n.l(Date.today)
  end

  def show; end

  def new; end

  def create; end

  def scrape
    ScrapeVocab.perform_later
  end
end
