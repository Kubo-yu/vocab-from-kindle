class VocabulariesController < ApplicationController
  def index
    @vocabularies = Kaminari.paginate_array(Vocabulary.all.order(id: "DESC")).page(params[:page])
  end

  def create; end

  def new; end

  def edit
    @vocabulary = Vocabulary.find(params[:vocabulary])
  end

  def update
    @vocabulary = Vocabulary.find(params[:id])
    if @vocabulary.update!(vocabulary_params)
      redirect_to vocabularies_path, notice: '保存に成功しました'
    else
      render :edit, alter: '保存に失敗しました'
    end
  end

  def book_vocab
    @book = Book.find(params[:book])
    @vocabularies = Kaminari.paginate_array(Vocabulary.where(book_id: @book.id).order(id: "DESC")).page(params[:page])
  end

  private

  def vocabulary_params
    params.require(:vocabulary).permit(:word, :phonics, :definition, :example)
  end
end
