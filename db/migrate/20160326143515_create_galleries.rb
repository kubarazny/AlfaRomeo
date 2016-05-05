class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
    	t.string "name"
    	t.integer "position"
    	t.text "description"
    	t.boolean "visible", :default=>false
    	t.attachment :photo

      t.timestamps null: false
    end
  end
  def down
  	drop_table :galleries
  end
end
