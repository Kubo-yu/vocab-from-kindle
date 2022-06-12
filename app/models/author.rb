# == Schema Information

# Table: authors

# id													:bigint
# name: 											:string
# author_book_id: 						:bigint
# created_at: 								:datatime
# updated_at: 								:datatime

class Author < ApplicationRecord
  has_many :author_books
  has_many :books, through: :author_books

  def create_or_find(author)
    # @todo: authorが複数いた時の処理追加
    Author.find_or_create_by(name: author)
  end
end
