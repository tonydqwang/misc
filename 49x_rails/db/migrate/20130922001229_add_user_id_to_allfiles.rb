class AddUserIdToAllfiles < ActiveRecord::Migration
  def change
    add_column :allfiles, :user_id, :integer
  end
end
