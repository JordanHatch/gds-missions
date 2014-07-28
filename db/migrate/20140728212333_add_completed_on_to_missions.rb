class AddCompletedOnToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :completed_on, :date
  end
end
