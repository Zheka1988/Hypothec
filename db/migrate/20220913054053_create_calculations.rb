class CreateCalculations < ActiveRecord::Migration[7.0]
  def change
    create_table :calculations do |t|
      t.integer 'apartment_price'
      t.integer 'accumulation'
      t.integer 'rental_cost'
      t.integer 'monthly_savings'
      t.integer 'mortgage_ids', array: true, default: []

      t.jsonb 'calculated_values', default: {}
      t.timestamps
    end
  end
end
