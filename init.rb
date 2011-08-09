require 'redmine'

require 'dispatcher'
require 'will_paginate'

Dispatcher.to_prepare :redmine_departments do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  Issue.send(:include, RedmineDepartments::IssuePatch) unless Issue.included_modules.include?(RedmineDepartments::IssuePatch)
  ApplicationController.send(:include, RedmineDepartments::ApplicationControllerPatch) unless ApplicationController.included_modules.include?(RedmineDepartments::ApplicationControllerPatch)
  Query.send(:include, RedmineDepartments::QueryPatch) unless Query.included_modules.include? RedmineDepartments::QueryPatch
end

require_dependency 'departments_show_issue_hook'

Redmine::Plugin.register :redmine_departments do
  name 'Redmine Departments plugin'
  author 'Nick Peelman'
  author_url 'http://peelman.us'
  url 'http://github.com/peelman/redmine_departments'
  description 'Departments Plugin for the LSSupport Group.  Icons are from the Silk collection, by FamFamFam'
  version '1.0.0'
    
  menu :top_menu, :departments, { :controller => :departments, :action => :index }, :caption => 'Departments'
  menu :admin_menu, :departments, {:controller => :departments, :action => :index }, :caption => 'Departments'
  
  project_module :departments do |map|
    map.permission :view_departments, { :departments => [:index, :show] }
    map.permission :add_departments, { :departments => :new }
    map.permission :edit_departments, { :departments => :edit }
    map.permission :delete_departments, { :departments => :delete }
    map.permission :add_issue_to_department, { :departments => :addissue }
    map.permission :remove_issue_from_department, { :departments => :removeissue }
  end

end
