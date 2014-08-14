class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :provider, null: false
      t.string :provider_uid, null: false
      t.string :image_url
    end
    add_index :users, :email, unique: true
  end
end
