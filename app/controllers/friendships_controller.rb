class FriendshipsController < ApplicationController
  
  def create
    return if current_user.id == params[:user_id]
    return unless current_user.viable_friend?(User.find(params[:user_id]))

    @friendship = current_user.send_a_request(params[:user_id])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: 'Friend_request sent!' }
      else
        format.html { redirect_to users_path, danger: @friendship.errors }
      end
    end
    # if @friendship.save
    #   flash[:notice] = 'Friend request sent!'
    # else
    #   flash[:danger] = 'Friend request failed!'
    # end
    # redirect_back(fallback_location: root_path)
  end

  def accept_request
    @friendship = current_user.accept_the_request(params[:user_id])

    check = @friendship.last 
    if check.updated_at > check.created_at
      flash[:notice] = 'Friend Request Accepted!'
    else
      flash[:danger] = 'Friend Request could not be accepted!'
    end
    redirect_back(fallback_location: root_path)
  end

  def decline_request
    @friendship = current_user.decline_the_request(params[:user_id])
    
    check = @friendship.last 
    check.destroy
    flash[:success] = 'Friend Request Declined!'
    redirect_back(fallback_location: root_path)
  end
end
