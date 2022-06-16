class AddColumnsToVocabularies < ActiveRecord::Migration[6.1]
  def change
    add_column :vocabularies, :scraping_id, :integer
  end
end
