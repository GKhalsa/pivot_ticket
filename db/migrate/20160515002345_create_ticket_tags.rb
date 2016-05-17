class CreateTicketTags < ActiveRecord::Migration
  def change
    create_table :ticket_tags do |t|
      t.references :ticket, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
