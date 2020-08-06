class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates_presence_of :sender_id, :receiver_id, uniqueness: true
  validates_presence_of :status, acceptance: { accept: %w[requested accepted declined] }

  scope :with_status, ->(status) { where 'status = ?', status }
  scope :friends, -> { where(status: 'accepted') }
  scope :not_friends, -> { where(status: 'requested') }
end
