class AddUniqueIndexTofriendships < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, [:sender_id, :receiver_id], unique: true
  end
end
