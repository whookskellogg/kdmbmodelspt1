class CreateActors < ActiveRecord::Migration[8.1]
  def change
    create_table :actors do |t|
      t.timestamps
      t.string "name"
    end
  end
end
