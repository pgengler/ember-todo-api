class RemoveUnusedColumnsFromItems < ActiveRecord::Migration[4.2]
  def change
    remove_column :items, :location
    remove_column :items, :start
    remove_column :items, :end
  end
end
