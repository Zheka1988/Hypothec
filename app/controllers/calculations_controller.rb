class CalculationsController < ApplicationController
  authorize_resource
  
  def new
    if !params[:page] || params[:page] == 'index'
      @calculation = Calculation.new
    elsif params[:page] =~ /^(mortgage-)\d{1,4}$/ && Mortgage.find(params[:page].split("-").last)
      @calculation = Calculation.new(mortgage_ids:[params[:page].split("-").last])
      @mortgage = Mortgage.find(params[:page].split("-").last)
    else
      @calculation = Calculation.new
      @calculation.errors.add(:mortgage_ids, 'invalid values')
    end
  end

  def show
    @calculation = Calculation.find(params[:id])
  end

  def create
    @calculation = Calculation.new(calculation_params)
    
    if params[:calculation][:mortgage_ids]
      @calculation.make_calculation(params[:calculation][:mortgage_ids])
    else
       @calculation.make_calculation(nil)
    end

    if @calculation.save
      redirect_to @calculation, notice: 'Calculation create successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def calculation_params
    params.require(:calculation).permit(:apartment_price,
                                        :accumulation,
                                        :rental_cost,
                                        :monthly_savings,
                                        mortgage_ids: [])

  end 
end
