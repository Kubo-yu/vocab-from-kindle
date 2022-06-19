class DropTableScrapings < ActiveRecord::Migration[6.1]
  def change
		drop_table :scrapings do |t|
			t.integer :status
			t.integer :vocabulary_quantity
			t.integer :book_id
			t.string :error
			t.timestamps
		end
  end
end
