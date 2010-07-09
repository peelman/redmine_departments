class DepartmentsController < ApplicationController
  unloadable

  def index
    @department_pages, @departments = paginate( :departments, :per_page => 25, :order => :name)
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
          if @department.errors.empty?
            page << "$('department_name').value = ''"
            page << "$('department_contact_names').value = ''"
          end
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
        flash[:error] = "Couldn't save the department."
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
            page.replace_html "departments", :partial => 'issues/departments', :locals => {:department => @department, :issue => @issue, :project => @project}
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
  
  def removeissue
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
    @department = Department.find(params[:department_id])
    respond_to do |format|
      if @department.issues.delete(@issue)
        format.html
        format.js do
          render :update do |page|
            page.replace_html "departments", :partial => 'issues/departments', :locals => {:department => @department, :issue => @issue, :project => @project}
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
