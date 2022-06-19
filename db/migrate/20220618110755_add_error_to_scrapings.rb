class AddErrorToScrapings < ActiveRecord::Migration[6.1]
  def change
    add_column :scrapings, :error, :text
  end
end
