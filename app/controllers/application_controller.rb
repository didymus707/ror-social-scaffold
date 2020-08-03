class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # # Return an appropriate friendship status message.
  # def friendship_status(user, friend)
  #   friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
  #   return "#{friend.name} is not your friend (yet)." if friendship.nil?
  #   case friendship.status
  #     when 'requested'
  #     "#{friend.name} would like to be your friend."
  #     when 'pending'
  #     "You have requested friendship from #{friend.name}."
  #     when 'declined'
  #     "You have declined this friendship from #{friend.name}."
  #     when 'accepted'
  #     "#{friend.name} is your friend."
  #     end
  #   end
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
  
end
