# == Schema Information

# Table: vocabularies

# id													:bigint
# word: 											:string
# phonics: 										:string
# definition: 								:text
# book_id: 										:integer
# example: 										:text
# scraping_id: 								:integer
# export_at: 								  :datatime
# created_at: 								:datatime
# updated_at: 								:datatime

class Vocabulary < ApplicationRecord
  belongs_to :book

  def self.vocab_not_scraped?(book)
    Vocabulary.where(book_id: book.id, definition: [nil, '']).count
  end

  def self.count_done(book)
    Vocabulary.where(book_id: book.id).where.not(definition: [nil, '']).count
  end

  def self.count_exported(book)
    Vocabulary.where(book_id: book.id).where.not(export_at: nil).count
  end
end
