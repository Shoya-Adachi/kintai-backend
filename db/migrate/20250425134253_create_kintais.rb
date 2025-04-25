class CreateKintais < ActiveRecord::Migration[8.0]
  def change
    create_table :kintais do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.time :entry_time
      t.time :leaving_time

      t.timestamps
    end
  end
end
