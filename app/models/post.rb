class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  def our_posts
    a = receivers.friends.pluck(:sender_id)
    b = senders.friends.pluck(:receiver_id)
    c = a + b
    Post.ordered_by_most_recent.includes(:user).where(id: c)
  end
end
