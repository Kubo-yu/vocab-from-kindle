class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.belongs_to :scrapping
      t.text :title
      t.integer :vocabulary_quantity
      t.timestamps
    end
  end
end
