class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
    	t.integer "page_id"
    	t.string "name"
    	t.integer "position"
    	t.boolean "visible", :default=>true
    	t.text "content"
    	t.attachment :photo

      t.timestamps null: false
    end
  end
  def down
  	drop_table :articles
  end
end
