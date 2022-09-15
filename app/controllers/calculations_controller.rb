class CalculationsController < ApplicationController
  authorize_resource
  
  def new
    @calculation = Calculation.new
  end

  def show
    @calculation = Calculation.find(params[:id])
  end

  def create
    @calculation = Calculation.new(calculation_params)
    create_hash_for_calculated_values

    if @calculation.save
      redirect_to @calculation, notice: 'Calculation create successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def calculation_params
    unless params[:calculation][:mortgage_ids]
      params[:calculation][:mortgage_ids] = []
      Mortgage.all.each do |mortgage|
        params[:calculation][:mortgage_ids] << mortgage.id
      end
    end

    params.require(:calculation).permit(:apartment_price,
                                        :accumulation,
                                        :rental_cost,
                                        :monthly_savings,
                                        mortgage_ids: [])

  end
  
  def create_hash_for_calculated_values
    params[:calculation][:mortgage_ids].each do |id|
      @calculation.calculated_values[id] = {
        an_initial_fee: [], rental_period: [], sum_rental_costs: [],
        mortgage_term: [], monthly_payment: [], overpayment: [],
        lost_money: [], full_term: [], mortgage_ids: [],
        interest_rate: []
      }
    end
  end  
end