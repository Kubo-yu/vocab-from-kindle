class VocabulariesController < ApplicationController
  before_action :set_q, only: [:index, :search]

  def index
    @vocabularies = Kaminari.paginate_array(Vocabulary.all.order(id: "DESC")).page(params[:page])
    @book = Book.all
  end

  def create; end

  def new; end

  def edit
    @vocabulary = Vocabulary.find(params[:id])
  end

  def update
    @vocabulary = Vocabulary.find(params[:id])
    if @vocabulary.update!(vocabulary_params)
      redirect_to vocabularies_path, notice: '保存に成功しました'
    else
      render :edit, alter: '保存に失敗しました'
    end
  end

  def destroy
    vocabulary = Vocabulary.find(params[:id])
    vocabulary.destroy ? (redirect_to request.referer, notice: "#{vocabulary.word}を削除しました。") : (redirect_to request.referer, notice: "#{vocabulary.word}の削除に失敗しました。")
  end

  def search
    @result = @q.page(params[:page])
    @book = Book.all
  end

  def book_vocab
    @book = Book.find(params[:book])
    @vocabularies = Kaminari.paginate_array(Vocabulary.where(book_id: @book.id).order(id: "DESC")).page(params[:page])
  end

  private

  def vocabulary_params
    params.require(:vocabulary).permit(:word, :phonics, :definition, :example)
  end

  def set_q
    @q = Vocabulary.ransack(book_id_eq: params[:book]).result
    @q = @q.ransack(phonics_or_definition_eq: 'not found').result if params[:not_found].present?
  end
end
