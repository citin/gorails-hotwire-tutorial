class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
