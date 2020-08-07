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

  def not_user_n_friends_with(user, link_text1, link_text2)
    return if user.name == current_user.name
    return unless current_user.viable_friend?(user)

    render partial: 'partials/other_users', locals: { user: user, link_text1: link_text1, link_text2: link_text2 }
  end

  def empty_requests
    render partial: 'partials/rr_partial' unless @received_requests.empty?
  end
end
