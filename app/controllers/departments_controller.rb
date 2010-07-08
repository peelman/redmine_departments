class DepartmentsController < ApplicationController
  before_filter :find_project, :authorize

  def index
    list
    render :action => 'list' unless request.xhr?
  end

  def list
    @department_pages, @departments = paginate :roles, :per_page => 25
    render :action => "list", :layout => false if request.xhr?
  end

 def new
    @department = Department.new(params[:name])
    @department.contact_names = params[:contact_names]
    @department.save if request.post?
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
      format.js do
        render :update do |page|
          page.replace_html "departments", :partial => 'issues/departments', :locals => {:issue => @issue, :project => @project}
          if @department.errors.empty?
            page << "$('department_name').value = ''"
            page << "$('department_contact_names').value = ''"
          end
        end
      end
    end
  end

  def destroy
    department = Department.find(params[:id])
    if request.post? && @issue.department.include?(department)
      department.destroy
      @issue.reload
    end
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
      format.js { render(:update) { |page| page.replace_html "departments", :partial => 'issues/departments', :locals => {:issue => @issue, :project => @project} } }
    end
  end

private
  def find_project
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
