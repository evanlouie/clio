module ApplicationHelper

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
