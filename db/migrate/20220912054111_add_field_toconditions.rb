class AddFieldToconditions < ActiveRecord::Migration[7.0]
  def change
    add_column :conditions, :value_interest_rate_with_commision, :float
    add_column :conditions, :value_interest_rate_without_commision, :float
    add_column :conditions, :value_interest_rate_with_proof_of_income, :float
    add_column :conditions, :value_interest_rate_without_proof_of_income, :float     
    add_column :conditions, :value_interest_rate_with_commision_with_proof_of_income, :float
    add_column :conditions, :value_interest_rate_with_commision_without_proof_of_income, :float
    add_column :conditions, :value_interest_rate_without_commision_with_proof_of_income, :float
    add_column :conditions, :value_interest_rate_without_commision_without_proof_of_income, :float   
  
    add_column :conditions, :value_max_loan_amount, :integer
    add_column :conditions, :value_max_loan_term, :integer
    add_column :conditions, :value_max_age, :integer
    add_column :conditions, :value_min_an_initial_fee, :integer
    add_column :conditions, :value_max_an_initial_fee, :integer
    add_column :conditions, :value_income, :integer

    add_column :conditions, :value_loan_processing_fee, :float
    add_column :conditions, :value_application_fee, :float   
    add_column :conditions, :value_arly_redemption_fee, :float
    add_column :conditions, :additional_expenses, :string
    add_column :conditions, :value_additional_expenses, :float

    add_column :conditions, :pledge, :string   
    add_column :conditions, :insurance, :string
    add_column :conditions, :value_insurance, :float  
  end
end
