class AddColumnsToScrapings < ActiveRecord::Migration[6.1]
  def change
    add_column :scrapings, :book_id, :integer
  end
end
