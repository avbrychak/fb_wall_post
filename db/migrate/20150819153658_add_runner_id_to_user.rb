class AddRunnerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :runner_id, :string
  end
end
