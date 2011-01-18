require_dependency 'query'

module RedmineDepartments
  # Patches Redmine's Queries dynamically, adding the Deliverable
  # to the available query columns
  module QueryPatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        #base.add_available_column(QueryColumn.new(:deliverable_subject, :sortable => "#{Deliverable.table_name}.subject"))

        alias_method_chain :available_filters, :departments
        alias_method_chain :statement, :departments
      end

    end

    module ClassMethods

      # Setter for +available_columns+ that isn't provided by the core.
      def available_columns=(v)
        self.available_columns = (v)
      end

      # Method to add a column to the +available_columns+ that isn't provided by the core.
      def add_available_column(column)
        self.available_columns << (column)
      end
    end

    module InstanceMethods

      # Wrapper around the +available_filters+ to add a new Departments filter
      def available_filters_with_departments
        @available_filters = available_filters_without_departments

#        if project
          departments_filters = { "department_id" => { :type => :list_optional, :order => 14,
              :values => Department.all().collect { |d| [d.name, d.id.to_s]}
            }}
#        else
#          departments_filters = { }
#        end
        return @available_filters.merge(departments_filters)
      end

      def statement_with_departments

        filters_clauses = []
        field = 'department_id'
        if has_filter?(field)
          departments_filter = filters[field].clone
          v = values_for(field).clone
          operator = operator_for(field)
          sql = ''
          db_table = 'issue_has_departments'
          db_field = field
          sql << "#{Issue.table_name}.id #{ operator == '=' ? 'IN' : 'NOT IN' } (SELECT #{db_table}.issue_id FROM #{db_table} WHERE "
          sql << sql_for_field(field, '=', v, db_table, db_field) + ')'
          filters_clauses << sql
          filters.delete(field)
        end
        filter_statement = (filters_clauses << statement_without_departments).join(' AND ')
        filters[field] = departments_filter unless departments_filter.nil?
        filter_statement
      end
    end
  end
end