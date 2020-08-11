class RenameLikesTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :likes, :post_likes
  end
end
