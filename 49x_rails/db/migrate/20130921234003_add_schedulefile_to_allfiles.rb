class AddSchedulefileToAllfiles < ActiveRecord::Migration
  def change
    add_column :allfiles, :schedulefile, :string
  end
end
