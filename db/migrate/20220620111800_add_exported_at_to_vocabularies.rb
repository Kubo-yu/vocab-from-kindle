class AddExportedAtToVocabularies < ActiveRecord::Migration[6.1]
  def change
    add_column :vocabularies, :export_at, :datetime
  end
end
