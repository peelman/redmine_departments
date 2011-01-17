
class DepartmentsShowIssueHook < Redmine::Hook::ViewListener

  # Renders the Departments
  #
  # Context:
  # * :issue => Issue being rendered
  #
#  def view_issues_show_details_bottom(context = {})
  def view_issues_form_details_bottom(context = {})
    if has_permission?(context)
      context[:controller].send(:render_to_string, {
        :partial => "issues/new/form",
        :locals => context
      })
    else
      return ''
    end
  end

  def view_issues_show_description_bottom(context = {})
    if has_permission?(context)
      context[:controller].send(:render_to_string, {
        :partial => "issues/departments",
        :locals => context
      })
    else
      return ''
    end
  end

  def controller_issues_new_before_save(context = {})
    set_departments_on_issue(context)
  end

  def controller_issues_edit_before_save(context = {})
    set_departments_on_issue(context)
  end

  def view_layouts_base_html_head(context)
    stylesheet_link_tag 'departments', :plugin => 'redmine_departments'
  end

private
  def protect_against_forgery?
    false
  end

  def has_permission?(context)
    context[:project].module_enabled?('departments') and User.current.allowed_to?(:view_departments, context[:project])
  end

  def set_departments_on_issue(context)
    if context[:params] && context[:params][:issue] && context[:params][:issue][:department_ids].present?
      context[:issue].departments = Department.find_all_by_id(context[:params][:issue][:department_ids].collect! {|i| i.to_i})
    end
    return ''
  end
end
