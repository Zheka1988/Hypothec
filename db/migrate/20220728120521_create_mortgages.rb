class CreateMortgages < ActiveRecord::Migration[7.0]
  def change
    create_table :mortgages do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
