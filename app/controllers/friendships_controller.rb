class FriendshipsController < ApplicationController
  def create
    return if current_user.id == params[:user_id]
    return unless current_user.viable_friend?(User.find(params[:user_id]))

    @friendship = current_user.send_a_request(params[:user_id])

    if @friendship.save
      flash[:notice] = 'Friend request sent!'
    else
      flash[:danger] = 'Friend request failed!'
    end
    redirect_back(fallback_location: root_path)
  end

  def accept_request
    @friendship = Friendship.find_by_user_id_and_friend_id(params[:user_id], current_user.id)

    @friendship.status = 'accepted'
    if @friendship.save
      flash[:notice] = 'Friend Request Accepted!'
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_back(fallback_location: root_path)
  end

  def decline_request
    @friendship = Friendship.find_by_user_id_and_friend_id(params[:user_id], current_user.id)

    @friendship.status = 'declined'
    @friendship.destroy
    flash[:notice] = 'Friend Request Declined!'
    redirect_back(fallback_location: root_path)
  end
end
