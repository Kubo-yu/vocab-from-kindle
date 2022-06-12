# == Schema Information

# Table: books

# id													:bigint
# title: 											:text
# author_book_id: 						:bigint
# vocabulary_quantity: 				:integer
# created_at: 								:datatime
# updated_at: 								:datatime

class Book < ApplicationRecord
  has_many :vocabularies

  has_many :author_books
  has_many :authors, through: :author_books

  validates :title, presence: true

  def update_vocabulary_quantity(vocabulary_quantity); end
end
