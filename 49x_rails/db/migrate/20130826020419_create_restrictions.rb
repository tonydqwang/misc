class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.integer :user_id
      t.datetime :begin_time
      t.datetime :end_time
      t.string :reason

      t.timestamps
    end
  end
end
