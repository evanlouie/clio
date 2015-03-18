module ApplicationHelper

  def name_with_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status-badge status-#{status}") +
      link_to("Update", status_user_path(user_id), :class => "update-link")
  end

  def user_status_badge(user)
    status = lambda do |user|
      if user.status == :in
        return "label label-success label-as-badge"
      else
        return "label label-default label-as-badge"
      end
    end
    ("<span class='status-container'>"+content_tag(
      :span,
      link_to(user.status.capitalize, status_user_path(user.id, format: :json), class: "status-badge"),
      class: status.call(user)
    )+"<span>").html_safe
  end

  def user_table_row(user)

    "<tr><td>" +
    link_to(user.full_name, user_path(user)) +
    "</td><td>" +
    user_status_badge(user) +
    "</td><td>"+link_to(user.team.name, team_path(user.team)) +
    "</td></tr>"

  end

end
