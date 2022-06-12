class CreateAuthorBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :author_books do |t|
      t.belongs_to :author
      t.belongs_to :book
      t.timestamps
    end
  end
end
