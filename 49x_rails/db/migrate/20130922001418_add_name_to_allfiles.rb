class AddNameToAllfiles < ActiveRecord::Migration
  def change
    add_column :allfiles, :name, :string
  end
end
