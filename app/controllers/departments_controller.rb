class DepartmentsController < ApplicationController
  
  unloadable
  
  def index
    @departments = Department.paginate :page => params[:page], :order => 'name ASC'
    @departmentCount = Department.count(:all)
    respond_to do |format|
      format.html
    end
  end

  def show
    @department = Department.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @department = Department.new
    @department.contacts.build
    respond_to do |format|
      format.html 
      format.js do
        render :update do |page|
          page.replace_html "departments", :partial => 'issues/departments', :locals => {:issue => @issue, :project => @project}
        end
      end
    end
  end

  def edit
    @department = Department.find(params[:id])
    @department.contacts.build
    respond_to do |format|
      format.html
    end
  end

  def update
    @department = Department.find(params[:id])
    respond_to do |format|
      if @department.update_attributes(params[:department])
        flash[:notice] = 'Department updated!'
        format.html { redirect_to @department }
      else
        format.html { render :edit }
      end
    end
  end
  
  def addissue
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
    @department = Department.find(params[:department][:department_id])
    respond_to do |format|
      if @department.issues<<@issue
        format.html
        format.js do
          render :update do |page|
            page.replace_html "issue-departments", :partial => 'issues/departments/list', :locals => {:department => @department, :issue => @issue, :project => @project}
          end
        end
      else
        format.js do
          render :update do |page|
            page.replace_html "issue-departments", :partial => 'issues/departments/list', :locals => {:department => @department, :issue => @issue, :project => @project}
          end
        end
      end
    end
  end
  
  def removeissue
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
    @department = Department.find(params[:department_id])
    @source = params[:source];
    respond_to do |format|
      if @department.issues.delete(@issue)
        format.html
        format.js do
          render :update do |page|
            if (@source == 'department')
              page.replace_html "department-issues", :partial => 'departments/issues/list', :locals => { :department => @department }
            elsif (@source == 'issue')
              page.replace_html "issue-departments", :partial => 'issues/departments/list', :locals => {:department => @department, :issue => @issue, :project => @project}
            else
              #do nothing
            end
          end
        end
      else
        format.js do
          render :update do |page|
            page.replace_html "departments", :partial => 'issues/departments', :locals => {:department => @department, :issue => @issue, :project => @project}
          end
        end
      end
    end
  end
  
  def removecontact
    @department = Department.find(params[:id])
    respond_to do |format|
      if @department.contacts.delete(Contact.find(params[:contact_id]))
        format.html { redirect_to @department }
        format.js do
          render :update do |page|
            page.replace_html "department-contacts", :partial => 'departments/contacts/list', :locals => {:department => @department, :issue => @issue, :project => @project}
          end
        end
      else
        format.js do
          render :update do |page|
            page.replace_html "departments", :partial => 'departments/contacts/list', :locals => {:department => @department, :issue => @issue, :project => @project}
          end
        end
      end
    end
  end

  def create
    @department = Department.new(params[:department])
    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_path }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @department = Department.find(params[:id])
    respond_to do |format|
      if @department.destroy
        flash[:notice] = "Department removed!"
        format.html { redirect_to departments_path }
        format.js { render(:update) { |page| page.replace_html "departments", :partial => 'departments/list', :locals => {:departments => @departments } } }
      else
        flash[:error] = "Couldn't delete department"
        format.html { redirect_to :controller => 'departments', :action => 'index' }
        format.js { render(:update) { |page| page.replace_html "departments", :partial => 'departments/list', :locals => {:departments => @departments } } }          
      end
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
