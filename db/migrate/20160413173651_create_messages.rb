class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.references :sub_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
