class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:id]).with_status('request')
    if @friendship.save
      flash[:notice] = 'Request sent'
      redirect_to :users_path
    else
      flash[:notice] = 'Request not sent for one reason. We wonder why?'
      redirect_to :users_path
    end
  end
end
