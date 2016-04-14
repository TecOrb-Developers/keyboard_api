class AddCategoryIdToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :category, index: true, foreign_key: true
  end
end
