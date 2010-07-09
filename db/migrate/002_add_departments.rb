class AddDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments, :force => true do |t|
      t.string "name", :limit => 100, :null => false
      t.string "abbreviation", :limit => 10, :null => true, :default => nil
      t.string "course_names", :limit => 200, :null => true, :default => nil
      t.string "contact_names", :limit => 200, :null => false, :default => nil
      t.string "contact_phones", :limit => 200, :null => true, :default => nil
      t.string "contact_emails", :limit => 200, :null => true, :default => nil
    end
  end

  def self.down
    drop_table :departments
  end
end
