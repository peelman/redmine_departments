class Department < ActiveRecord::Base
  has_and_belongs_to_many :issues, :join_table => "issue_has_departments"
  has_many :contacts, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :contacts
  
end
