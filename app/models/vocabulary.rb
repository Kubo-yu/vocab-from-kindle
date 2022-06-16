# == Schema Information

# Table: vocabularies

# id													:bigint
# word: 											:string
# phonics: 										:string
# definition: 								:text
# book_id: 										:integer
# example: 										:text
# scraping_id: 								:integer
# created_at: 								:datatime
# updated_at: 								:datatime

class Vocabulary < ApplicationRecord
  belongs_to :book

  def self.vocab_not_scraped?(book)
    Vocabulary.where(book_id: book.id, definition: nil).count
  end

  def self.count_done(_book)
    Vocabulary.where.not(definition: nil).count
  end
end
