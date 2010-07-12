# via http://www.redmine.org/boards/2/topics/3708

class RedmineMyPluginHookListener < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context)
    stylesheet_link_tag 'departments', :plugin => 'redmine_departments'
  end
end