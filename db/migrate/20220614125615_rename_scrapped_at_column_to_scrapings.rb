class RenameScrappedAtColumnToScrapings < ActiveRecord::Migration[6.1]
  def change
    rename_column :scrapings, :scrapped_at, :scraped_at
  end
end
