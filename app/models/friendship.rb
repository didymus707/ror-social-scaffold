class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates_presence_of :user_id, :friend_id, uniqueness: true
  validates_presence_of :status, acceptance: { accept: %w[pending, requested accepted declined] }

  scope :friends, -> { where(status: 'accepted') }
  scope :not_friends, -> { where(status: ['requested', 'pending']) }

  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(sender, friend)
    unless sender == friend || Friendship.exists?(sender, friend)
      transaction do
        create(user_id: sender, friend_id: friend, status: 'pending')
        create(user_id: friend, friend_id: sender, status: 'requested')
      end
    end
  end

  def self.accept(user, friend)
    transaction do
      updated_at = Time.now
      accept_one_part(user, friend, updated_at)
      accept_one_part(friend, user, updated_at)
    end
  end

  def self.decline(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
    end
  end

  def self.accept_one_part(user, friend, updated_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.updated_at = updated_at
    request.save
  end

end
