class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :performing
      t.date :date
      t.references :category, index: true, foreign_key: true
    end
  end
end
