class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
    	t.integer "galleries_id"
    	t.string "name"
    	t.integer "position"
    	t.boolean "visible", :default =>true
    	t.string "description"
    	t.attachment :photo

      t.timestamps null: false
    end
  end
  def down
  	drop_table :photos
  end
end
