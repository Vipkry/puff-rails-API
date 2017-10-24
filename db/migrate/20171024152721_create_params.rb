class CreateParams < ActiveRecord::Migration[5.1]
  def change
    create_table :params do |t|
      t.string :name

      t.timestamps
    end
  end
end
