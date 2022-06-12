# == Schema Information

# Table: vocabularies

# id													:bigint
# word: 											:string
# phonics: 										:string
# definition: 								:text
# obtained_at: 								:datetime
# book_id: 										:integer
# example: 										:text
# created_at: 								:datatime
# updated_at: 								:datatime

class Vocabulary < ApplicationRecord
  belongs_to :book
end
