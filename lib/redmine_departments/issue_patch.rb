module RedmineDepartments
  # Patches Redmine's Issues dynamically. Adds a relationship
  # Issue +has_many+ to IssueDepartment
  module IssuePatch
    def self.included(base) # :nodoc:
      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        has_and_belongs_to_many :departments, :join_table => "issue_has_departments"
      end
   
    end
  end
end
