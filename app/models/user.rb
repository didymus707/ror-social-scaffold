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

  has_many :senders, foreign_key: 'sender_id', class_name: 'Friendship'
  has_many :receivers, foreign_key: 'receiver_id', class_name: 'Friendship'

  def all_friends
    a = receivers.friends.pluck(:sender_id)
    b = senders.friends.pluck(:receiver_id)
    c = a + b
    User.where(id: c)
  end

  def friend?(user)
    receivers.friends.where(sender_id: user).exists? || senders.friends.where(receiver_id: user).exists?
  end

  def request_sent?(receiver)
    senders.exists?(receiver_id: receiver)
  end

  def request_received?(sender)
    receivers.exists?(sender_id: sender)
  end

  def viable_friend?(friend)
    if request_received?(friend) || request_sent?(friend) || friend?(friend)
      false
    else
      true
    end
  end

  def pending_requests
    a = senders.not_friends.pluck(:receiver_id)
    User.where(id: a)
  end

  def received_requests
    b = receivers.not_friends.pluck(:sender_id)
    User.where(id: b)
  end

  def send_a_request(id)
    senders.build(receiver_id: id, status: 'requested')
  end

end
