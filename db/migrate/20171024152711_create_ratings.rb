class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rate
      t.integer :user_id
      t.integer :teacher_id
      t.integer :param_id

      t.timestamps
    end
  end
end
