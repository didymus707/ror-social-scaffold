class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :comment_likes, dependent: :destroy

  has_many :friendships
  has_many :inverted_friendships, foreign_key: 'friend_id', class_name: 'Friendship'

  def all_friends
    a = inverted_friendships.friends.pluck(:user_id)
    b = friendships.friends.pluck(:friend_id)
    c = a + b
    User.where(id: c)
  end

  def friend?(user)
    inverted_friendships.friends.where(user_id: user).exists? || friendships.friends.where(friend_id: user).exists?
  end

  def request_sent?(receiver)
    friendships.exists?(friend_id: receiver)
  end

  def request_received?(sender)
    inverted_friendships.exists?(user_id: sender)
  end

  def viable_friend?(friend)
    if request_received?(friend) || request_sent?(friend) || friend?(friend)
      false
    else
      true
    end
  end

  def pending_requests
    a = friendships.not_friends.pluck(:friend_id)
    User.where(id: a)
  end

  def received_requests
    b = inverted_friendships.not_friends.pluck(:user_id)
    User.where(id: b)
  end

  def send_a_request(id)
    friendships.build(friend_id: id, status: 'requested')
  end
end
