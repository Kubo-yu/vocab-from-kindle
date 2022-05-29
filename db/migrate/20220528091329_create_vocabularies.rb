class CreateVocabularies < ActiveRecord::Migration[6.1]
  def change
    create_table :vocabularies do |t|
      t.belongs_to :book
      t.string :word
      t.string :phonics
      t.text :definition
      t.text :example
      t.datetime :obtained_at
      t.timestamps
    end
  end
end
