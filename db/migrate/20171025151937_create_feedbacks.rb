class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.string :text
      t.integer :user_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
