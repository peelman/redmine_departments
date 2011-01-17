module RedmineDepartments
  module ApplicationControllerPatch
    def self.included(base) # :nodoc:
      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        helper DepartmentsHelper
      end
    end
  end
end
