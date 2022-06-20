class BooksController < ApplicationController
  include Import

  def index
    @books = Book.all.order(id: "DESC")
  end

  def create; end

  def new; end

  def show; end

  def import
    # fileはtmpに自動で一時保存される
    Import::ImportCsv.import(params[:file])
    redirect_to root_url, notice: '本のインポートが完了しました'
  end

  def export
    book = Book.find(params[:book_id])
    vocabularies = Vocabulary.where(book_id: book.id, export_at: [nil, ''])
    ApplicationRecord.transaction do
      respond_to do |format|
        format.html
        format.csv do |_csv|
          generate_csv(vocabularies, book)
        end
      end
      current_time = DateTime.now
      vocabularies.each do |vocabulary|
        vocabulary.update!(export_at: current_time)
      end
    end
  end

  def scrape
    book_id = params[:book_id]
    ScrapeVocab.perform_later(book_id)
    redirect_to root_url, notice: 'スクレイピングを開始しました'
  end

  private

  def generate_csv(vocabularies, book)
    csv = CSV.generate do |csv|
      vocabularies.each do |vocabulary|
        csv.add_row([
                      vocabulary.word,
                      vocabulary.phonics,
                      vocabulary.example,
                      vocabulary.definition
                    ])
      end
    end
    time_now = Time.zone.now.strftime('%Y%m%d%H%M%S')
    send_data csv, filename: "Vocabularies_#{book.title}_#{time_now}.csv", type: :csv
  end
end
