class CreateAllfiles < ActiveRecord::Migration
  def change
    create_table :allfiles do |t|

      t.timestamps
    end
  end
end
