class CreateScrappings < ActiveRecord::Migration[6.1]
  def change
    create_table :scrappings do |t|
      t.datetime :scrapped_at
      t.integer :book_quantity
      t.integer :vocabulary_quantity
      t.integer :status
      t.timestamps
    end
  end
end
