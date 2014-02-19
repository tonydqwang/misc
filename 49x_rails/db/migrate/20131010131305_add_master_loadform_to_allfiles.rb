class AddMasterLoadformToAllfiles < ActiveRecord::Migration
  def change
    add_column :allfiles, :master_loadform, :string
  end
end
