class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follower_id, foreign_key: { to_table: :end_users }
      t.integer :followed_id, foreign_key: { to_table: :endusers }

      t.timestamps
    end
  end
end
