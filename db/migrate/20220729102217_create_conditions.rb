class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string :interest_rate
      t.string :max_loan_amount
      t.string :max_loan_term
      t.string :max_age
      t.text :income
      t.text :note
      t.string :an_initial_fee
      t.text :experience_and_registration
      t.string :type_of_housing
      t.references :mortgage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
