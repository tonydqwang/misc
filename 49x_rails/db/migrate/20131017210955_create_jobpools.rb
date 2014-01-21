class CreateJobpools < ActiveRecord::Migration
  def change
    create_table :jobpools do |t|
      t.integer :pool_id
      t.integer :job_id

      t.timestamps
    end
  end
end
