map.connect 'issues/:issue_id/departments/:action/:id', :controller => 'issue_departments'
map.connect 'departments', :controller => 'department', :action => 'index'
