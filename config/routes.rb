ActionController::Routing::Routes.draw do |map|
  map.connect 'issues/:issue_id/departments/:action/:id', :controller => 'issue_departments'
  map.resources :departments, :only => :index
end
