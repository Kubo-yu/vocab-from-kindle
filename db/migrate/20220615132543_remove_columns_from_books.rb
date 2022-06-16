class RemoveColumnsFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :scraping_id, :integer
  end
end
