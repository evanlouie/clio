module ApplicationHelper

  def name_with_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status-badge status-#{status}") +
      link_to("Update", status_user_path(user_id), :class => "update-link")
  end

  def user_status_badge(user)
    class_name = ""
    if user.status == :in
      class_name = "status-badge label label-success label-as-badge"
    else
      class_name = "status-badge label label-default label-as-badge"
    end
    "<span class='#{class_name}'>#{user.status.capitalize}</span>".html_safe
  end

end
