class AddFieldToMortgages < ActiveRecord::Migration[7.0]
  def change
    add_column :mortgages, :type_mortgage, :integer, default: 0

    add_column :mortgages, :title_banks_partners, :string, array: true, default: []
  end
end
