module ApplicationHelper

  def name_with_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status status-#{status}") +
      link_to("Update", status_user_path(user_id), :class => "update-link")
  end

  def user_table_row(user)
    status = lambda do |user|
      if user.status == :in
        return "label label-success"
      else
        return "label label-warning"
      end
    end
    "<tr><td>" +
    link_to(user.full_name, user_path(user)) +
    "</td><td>" +
    content_tag(:span, link_to(user.status.capitalize, status_user_path(user.id, format: :json), class: "status"), class: status.call(user)) +
    "</td><td>"+link_to(user.team.name, team_path(user.team)) +
    "</td></tr>"

  end

end
