# == Schema Information

# Table: author_books

# id													:bigint
# book_id											:bigint
# author_id										:bigint

class AuthorBook < ApplicationRecord
  belongs_to :author
  belongs_to :book
end
