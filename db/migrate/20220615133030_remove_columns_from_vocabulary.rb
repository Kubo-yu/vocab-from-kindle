class RemoveColumnsFromVocabulary < ActiveRecord::Migration[6.1]
  def change
    remove_column :vocabularies, :obtained_at, :datetime
  end
end
