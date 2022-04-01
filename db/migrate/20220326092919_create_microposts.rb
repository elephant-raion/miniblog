class CreateMicroposts < ActiveRecord::Migration[6.1]
  def change
    create_table :microposts do |t|
      t.text :content, null: false
      t.datetime :posted_at, null: false

      t.timestamps
    end
  end
end
