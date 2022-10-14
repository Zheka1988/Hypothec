class AddAuthorToCalculations < ActiveRecord::Migration[7.0]
  def change
    add_reference :calculations, :author, foreign_key: { to_table: :users }
  end
end
