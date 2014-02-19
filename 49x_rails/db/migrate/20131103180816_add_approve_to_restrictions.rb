class AddApproveToRestrictions < ActiveRecord::Migration
  def change
    add_column :restrictions, :approve, :boolean
  end
end
