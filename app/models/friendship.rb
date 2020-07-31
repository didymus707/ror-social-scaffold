class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: 'friend_id'

  validates_presence_of :user_id, :friend_id
  validates_presence_of :status, acceptance: { accept: %w[pending requested accepted declined] }

  scope :with_status, ->(status) { where 'friendships.status = ?', status }

  def self.exists?(u, f)
    !find_by_user_id_and_friend_id(u, f).nil?
  end

  def self.send_requests(u, f, str)
    unless u == f && Friendship.exists?(u,f)
      create(user_id: u, friend_id: f, status: str)
    end
    receive_requests(u, f, str)
  end

  # def self.receive_requests(u, f, str)
  #   if user != friend || where(u, f)
  #     create(friend_id: u, user_id: f, status: str)
  #   end
  # end

end
