class AddMissionPatchToMission < ActiveRecord::Migration
  def change
    add_column :missions, :mission_patch, :string
  end
end
