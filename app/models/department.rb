class Department < ActiveRecord::Base
  has_and_belongs_to_many :issues, :join_table => "issue_has_departments"
  has_many :contacts, :dependent => :destroy

  cattr_reader :per_page
  @@per_page = 20
  validates_presence_of :name


  accepts_nested_attributes_for :contacts, :reject_if => lambda { |contact| contact[:name].blank? || contact[:email].blank? }, :allow_destroy => true

end
