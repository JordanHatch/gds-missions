class AddShortDescriptionToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :short_description, :string
  end
end
