# db/migrate/xxxx_create_teachers.rb
class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.string :name, null: false
      t.string :field, null: false
      t.text :bio, null: false

      t.timestamps
    end
  end
end
