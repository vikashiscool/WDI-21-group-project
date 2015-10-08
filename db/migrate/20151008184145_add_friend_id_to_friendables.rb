class AddFriendIdToFriendables < ActiveRecord::Migration
  def change
    rename_column :friendables, :to_id, :friend_id
  end
end
