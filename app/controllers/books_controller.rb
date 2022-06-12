class BooksController < ApplicationController
  include Import

  def index
    @books = Book.all
  end

  def create; end

  def new; end

  def show; end

  def import
    # fileはtmpに自動で一時保存される
    Import::ImportCsv.import(params[:file])
    redirect_to root_url, notice: '本のインポートが完了しました'
  end
end
