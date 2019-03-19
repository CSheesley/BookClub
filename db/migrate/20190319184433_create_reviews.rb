class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :text
      t.integer :rating
      t.string :user
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
