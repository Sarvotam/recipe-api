class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :rating
      t.string :comment
       t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
