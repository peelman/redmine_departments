class Department < ActiveRecord::Base
  has_and_belongs_to_many :issues, :join_table => "issue_has_departments"

  validates_presence_of :name, :contact_names
  validates_uniqueness_of :name

end
