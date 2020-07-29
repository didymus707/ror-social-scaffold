class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, ->  { where status: 'accepted' }
  has_many :friends, through: :friendships, source: :friend

  has_many :sent_requests, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :received_requests, class_name: 'Friendship', foreign_key: 'friend_id'

  def pending_requests
    sent_requests.with_status('pending')
  end

  def received_requests
    received_requests.with_status(['requested'])
  end

  def friend?(user)
    friends.include?(user)
  end
end
