class AddUserIdToFriendables < ActiveRecord::Migration
  def change
  	rename_column :friendables, :from_id, :user_id
  end
end
