class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.timestamps
      t.integer "movie_id"
t.integer "actor_id"
t.string "character_name"
    end
  end
end
