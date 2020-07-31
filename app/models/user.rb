class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, ->  { where status: 'accepted' } #foreign_key: 'friend_id'
  has_many :sent_request, -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'user_id', inverse_of: 'user'
  has_many :friend_request, -> { where status: 'requested' }, class_name: 'Friendship', foreign_key: 'friend_id', inverse_of: 'friend'

  has_many :friends, through: :friendships
  has_many :pending_requests, through: :sent_request, source: 'friend'
  has_many :received_requests, through: :friend_request, source: 'user'

  def friend?(user)
    friends.include?(user)
  end

  def request_sent?(user)
    sent_request.exists?(friend_id: user)
  end

  def request_received?(user)
    friend_request.exists?(user_id: user)
  end

  def viable_friend?(user_id)
    request_sent?(user_id) || request_received?(user_id)
  end

end
