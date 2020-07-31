class FriendshipsController < ApplicationController
  
  def create
    return if current_user.id == params[:user_id]
    return if request_sent?(User.find(params[:user_id]))
    return if request_received?(User.find(params[:user_id]))

    @user = User.find(params[:user_id])
    @friendship = current_user.sent_requests.build(friend_id: params[:user_id])
    if @friendship.save
      flash[:success] = 'Friend request sent!'
    else
      flash[:danger] = 'Friend request failed!'
    end
    redirect_back(fallback_location: root_path)
  end

  def accept_request
    @friendship = Friendship.find_by_user_id_and_friend_id(params[:user_id], current_user.id, status: 'requested')
    return unless @friendship 

    @friendship.status = 'accepted'
    if @friendship.save
      flash[:success] = 'Friend Request Accepted!'
      @friendship2 = current_user.sent_requests.build(friend_id: params[:user_id], status: 'accepted')
      @friendship2.save
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_back(fallback_location: root_path)
  end

  def decline_request
    @friendship = Friendship.find_by_user_id_and_friend_id(params[:user_id], current_user.id, status: 'requested')
    return unless @friendship

    @friendship.status = 'declined'
    @friendship.destroy
    flash[:success] = 'Friend Request Declined!'
    redirect_back(fallback_location: root_path)
  end
end
