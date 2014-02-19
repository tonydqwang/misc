class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.integer :job_id
      t.datetime :begin_time
      t.datetime :end_time
	  t.string :info
	  
      t.timestamps
    end
  end
end
