class AddTeamIdToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :team_id, :integer
  end
end
