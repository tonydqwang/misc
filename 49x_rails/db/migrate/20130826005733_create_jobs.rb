class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :department_id
      t.string :name
      t.boolean :in_hospital

      t.timestamps
    end
  end
end
