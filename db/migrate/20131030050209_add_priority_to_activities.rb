class AddPriorityToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :priority, :integer, default: 0
  end
end
