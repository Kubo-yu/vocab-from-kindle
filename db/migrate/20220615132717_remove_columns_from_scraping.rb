class RemoveColumnsFromScraping < ActiveRecord::Migration[6.1]
  def change
    remove_column :scrapings, :scraped_at, :datetime
    remove_column :scrapings, :book_quantity, :integer
  end
end
