class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :start
      t.date :end
      t.string :name

      t.timestamps
    end
  end
end
