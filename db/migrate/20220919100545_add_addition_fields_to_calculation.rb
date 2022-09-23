class AddAdditionFieldsToCalculation < ActiveRecord::Migration[7.0]
  def change
    add_column :calculations, :addition_mortgage_term, :string
    add_column :calculations, :addition_initial_fee, :string
    add_column :calculations, :addition_income, :integer
    add_column :calculations, :addition_proof_of_income, :boolean, default: false
    add_column :calculations, :addition_age, :integer
    add_column :calculations, :addition_pledge, :boolean, default: false
    add_column :calculations, :addition_operating_loans, :integer
    add_column :calculations, :addition_type_of_housing, :string, array: true, default: []
    add_column :calculations, :addition_city, :string
    add_column :calculations, :addition_bank, :string, array: true, default: []
    
    add_column :calculations, :enable_default_mortgage_term, :boolean, default: true
    add_column :calculations, :enable_default_initial_fee, :boolean, default: true
  end
end
