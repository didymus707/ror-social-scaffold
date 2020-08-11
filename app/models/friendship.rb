class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates_presence_of :user_id, :friend_id, uniqueness: true
  validates_presence_of :status, acceptance: { accept: %w[requested accepted declined] }

  scope :with_status, ->(status) { where 'status = ?', status }
  scope :friends, -> { where(status: 'accepted') }
  scope :not_friends, -> { where(status: 'requested') }
end
