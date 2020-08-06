class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    # @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    a = current_user.receivers.friends.pluck(:sender_id)
    b = current_user.senders.friends.pluck(:receiver_id)
    c = a + b
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user).where(id: c)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
