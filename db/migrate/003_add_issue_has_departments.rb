class AddIssueHasDepartments < ActiveRecord::Migration
  def self.up
    create_table :issue_has_departments, :id => false do |t|
      t.integer "department_id"
      t.integer "issue_id"
    end
  end

  def self.down
    drop_table :issue_has_departments
  end
end

