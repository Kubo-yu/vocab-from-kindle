class RemoveColumnsFromBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :vocabulary_quantity, :integer
  end
end
