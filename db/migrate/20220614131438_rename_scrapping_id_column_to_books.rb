class RenameScrappingIdColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :scrapping_id, :scraping_id
  end
end
