class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer  :parent_id, null: true,  index: true
      t.integer  :lft,       null: false, index: true
      t.integer  :rgt,       null: false, index: true

      t.string   :slug,         index: true
      t.string   :path,         index: true
      t.string   :title
      t.string   :keywords
      t.string   :description
      t.text     :body
      t.datetime :published_at, index: true

      t.timestamps null: false
    end
  end
end
