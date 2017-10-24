class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :photo
      t.string :name
      t.string :subject

      t.timestamps
    end
  end
end
