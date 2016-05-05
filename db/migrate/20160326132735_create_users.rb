class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
    	t.string "name", :limit=>20
    	t.string "surname", :limit=>50
    	t.string "user", :limit=>25
    	t.string "email", :limit=>60, :default=>"", :null=>false
    	t.string "phone", :default=>"", :null=>false
    	t.string "name", :limit=>20
    	t.string "password_digest"

      t.timestamps
    end
    add_index("users", "user")
  end
    def down
    	drop_table :users
    end

end
