class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :content #データ型はtextに変更
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true, dependent: :destroy

      t.timestamps
    end
  end
end
