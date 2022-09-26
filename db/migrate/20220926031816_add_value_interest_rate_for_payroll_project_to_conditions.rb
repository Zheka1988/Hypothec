class AddValueInterestRateForPayrollProjectToConditions < ActiveRecord::Migration[7.0]
  def change
    add_column :conditions, :value_interest_rate_for_payroll_project, :float
  end
end
