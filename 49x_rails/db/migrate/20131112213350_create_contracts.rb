class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.datetime :begin_time
      t.datetime :end_time
      t.integer :employee_id

      t.timestamps
    end
  end
end
