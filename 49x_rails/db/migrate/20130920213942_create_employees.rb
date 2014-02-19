class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :department_id
      t.integer :user_id

      t.timestamps
    end
  end
end
