class AddStateToMissions < ActiveRecord::Migration
  class Mission < ActiveRecord::Base
  end

  def change
    add_column :missions, :state, :string

    Mission.reset_column_information
    reversible do |dir|
      dir.up { Mission.update_all state: 'in_progress' }
    end
  end
end
