class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end