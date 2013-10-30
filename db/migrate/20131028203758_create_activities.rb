class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false, limit: 100
      t.timestamps
    end
  end
end
