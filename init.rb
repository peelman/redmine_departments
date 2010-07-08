require 'redmine'

require 'dispatcher'


Dispatcher.to_prepare :redmine_departments do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineDepartments::IssuePatch
    Issue.send(:include, RedmineDepartments::IssuePatch)
  end
end

require_dependency 'departments_show_issue_hook'

Redmine::Plugin.register :redmine_departments do
  name 'Redmine Departments plugin'
  author 'Nick Peelman'
  description 'Departments Plugin for the LSSupport Group'
  version '0.0.1'

  permission :departments, {:departments => [:index]}, :public => true
  menu :top_menu, :departments, { :controller => 'departments', :action => 'index' }, :caption => 'Departments', :after => :new, :param => :project_id
  
  #permission :department, {:department => [:index]}, :public => true
  #menu :project_menu, :department, { :controller => 'department', :action => :project_id }, :caption => 'Departments', :after => :activity, :param => :project_id
  
  project_module :departments do |map|
    map.permission :view_departments, { :departments => :index }
    map.permission :add_departments, { :issue_departments => :new }
    map.permission :delete_departments, { :issue_departments => :destroy }
  end

end

