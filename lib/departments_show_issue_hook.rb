# Extension to ViewListener to allow an :if parameter to render_on.
# See <http://www.redmine.org/boards/3/topics/show/4316>
module Redmine
  module Hook
    class ViewListener
      def self.render_on(hook, options={})
        define_method hook do |context|
          if !options.include?(:if) || evaluate_if_option(options[:if], context)
            context[:controller].send(:render_to_string, {:locals => context}.merge(options))
          end
        end
      end

      private

      def evaluate_if_option(if_option, context)
        case if_option
        when Symbol
          send(if_option, context)
        when Method, Proc
          if_option.call(context)
        end        
      end
    end
  end
end

class ShowIssueDepartmentsHook < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => "issues/departments", :if => :has_permission? 

private
  def protect_against_forgery?
    false
  end

  def has_permission?(context)
    context[:project].module_enabled?('departments') and User.current.allowed_to?(:view_departments, context[:project])
  end
end

class ShowNewIssueDepartmentsHook < Redmine::Hook::ViewListener
  render_on :view_issues_form_details_bottom, :partial => "issues/new/form", :if => :has_permission? 

private
  def protect_against_forgery?
    false
  end

  def has_permission?(context)
    context[:project].module_enabled?('departments') and User.current.allowed_to?(:view_departments, context[:project])
  end
end
