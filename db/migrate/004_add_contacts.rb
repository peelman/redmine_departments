class AddContacts < ActiveRecord::Migration
  def self.up
    remove_column :departments, :contact_names
    remove_column :departments, :contact_emails
    remove_column :departments, :contact_phones

    create_table :contacts, :force => true do |t|
      t.string "name", "email", "phone"
      t.integer "department_id"
      t.timestamps
    end
    add_index :contacts, :department_id
  end

  def self.down
    remove_index :contacts, :column => :department_id
    drop_table :contacts

    add_column :departments, :contact_phones, :limit => 200, :null => false, :default => nil
    add_column :departments, :contact_emails, :limit => 200, :null => false, :default => nil
    add_column :departments, :contact_names, :limit => 200, :null => false, :default => nil
  end
end
