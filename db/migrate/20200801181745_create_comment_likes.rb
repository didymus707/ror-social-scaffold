class CreateCommentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_likes do |t|
      t.references :user
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
