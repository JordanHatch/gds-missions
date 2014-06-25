class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :missions, :slug, unique: true
  end
end
