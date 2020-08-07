module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = PostLike.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_post_like_path(id: post_like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_post_likes_path(post_id: post.id), method: :post)
    end
  end

  def not_user_n_friends_with(user, link_text_1, link_path_1, link_path_2, link_text_2)
    unless user.name == current_user.name
      if current_user.viable_friend?(user)
        if current_page?(user_path(user))
          content_tag_name(link_text_1, link_path_1, link_path_2, link_text_2)
        elsif current_page?(users_path)
          content_tag(:li, content_tag(:h4, 'user.name')) do
            content_tag_name(link_text_1, link_path_1, link_path_2, link_text_2)
          end
        end
      end
    end
  end

  def content_tag_name(link_text_1, link_path_1, link_path_2, link_text_2)
    content_tag(:span) do
      link_to(link_text_1, link_path_1, class: 'profile-link' )
    end
    content_tag(:span) do
      link_to(link_path_2, method: :post, data: {confirm: "Are you sure you want to add this friend?" } ) do
        button_tag link_text_2
      end 
    end
  end

  # def friends_with(user)
  #   unless current_user.friend?(user) %>
  #     <li>
  #       <%= user.name %>
  #       <span class="profile-link">
  #         <%= link_to 'See Profile',  user_path(user), class: 'profile-link' %>
  #           <%= link_to accept_request_user_friendships_path(user), data: {confirm: "Are you sure about this?" } do %>
  #             <button>Accept</button>
  #           <% end %>
  #           <%= link_to decline_request_user_friendships_path(user), data: {confirm: "Are you sure about this?" } do %>
  #             <button>Decline</button>
  #           <% end %>
  #       </span>
  #     </li>
  #   <% end %>
  # end
end
