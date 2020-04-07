class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.string :publisher
      t.string :genre
      t.text :image
      t.string :isbn

      t.timestamps
    end
  end
end
