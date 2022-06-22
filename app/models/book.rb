# == Schema Information

# Table: books

# id													:bigint
# title: 											:text
# created_at: 								:datatime
# updated_at: 								:datatime

class Book < ApplicationRecord
  has_many :vocabularies
  has_many :scrapings

  has_many :author_books
  has_many :authors, through: :author_books

  validates :title, presence: true

  def self.book_title?(book_id)
    book = Book.find(book_id)
    book.title
  end

  # 以下サービス層に書くか
  def self.book_author?(book)
    author_book = AuthorBook.find_by(book_id: book.id)
    author = Author.find(author_book.author_id)
    author.name
  end

  def self.vocabulary_quantity?(book)
    Vocabulary.where(book_id: book.id).count
  end
end
