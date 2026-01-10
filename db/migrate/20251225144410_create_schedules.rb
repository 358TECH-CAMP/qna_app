class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :teacher, null: false, foreign_key: true
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
