class Contact < ActiveRecord::Base
  belongs_to :department

  validates_presence_of :name
end
