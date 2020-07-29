class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: 'friend_id'

  validates_presence_of :user_id, :friend_id
  validates_presence_of :status, acceptance: { accept: %w[pending requested accepted declined] }

  scope :with_status, ->(status) { where 'friendships.status = ?', status }

  def self.exists?
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.send_requests(user, friend, status)
    unless user == friend || Friendship.exists?(user, friend)
      create(user_id: user, friend_id: friend, status: 'requested')
    end
  end

  def self.receive_requests(user, friend, status)
    unless user == friend || Friendship.exists?(user, friend)
      create(friend_id: user, user_id: friend, status: [ 'accepted', 'declined' ])
    end
  end

end
