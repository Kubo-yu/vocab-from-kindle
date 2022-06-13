class VocabulariesController < ApplicationController
  def index
    @vocabularies = Vocabulary.all
  end

  def create; end

  def new; end

  def show; end

  def book_vocab
    @book = Book.find(params[:book])
    @vocabularies = Vocabulary.where(book_id: @book.id)
  end
end
