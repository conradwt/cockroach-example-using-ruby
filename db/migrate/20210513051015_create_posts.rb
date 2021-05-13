class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
