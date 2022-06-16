class ChangeScrappingsToScrapings < ActiveRecord::Migration[6.1]
  def change
    rename_table :scrappings, :scrapings
  end
end
