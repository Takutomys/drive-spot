class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|

      t.timestamps
      t.integer :end_user_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
    end
  end
end
