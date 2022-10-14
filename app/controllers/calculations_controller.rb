class CalculationsController < ApplicationController
  authorize_resource
  
  before_action :fill_array_title_city
  
  def index
    if current_user&.admin
      @calculations = Calculation.all
    elsif current_user
      @calculations = Calculation.where(author: current_user)
    else
      redirect_to new_user_session_path, notice: t('flash.calculations.index')
    end
  end

  def new
    if !params[:page] || params[:page] == 'index'
      @calculation = Calculation.new
    elsif params[:page] =~ /^(mortgage-)\d{1,4}$/ && Mortgage.find(params[:page].split("-").last)
      @calculation = Calculation.new(mortgage_ids:[params[:page].split("-").last])
      @mortgage = Mortgage.find(params[:page].split("-").last)
    else
      @calculation = Calculation.new
      @calculation.errors.add(:mortgage_ids, t('flash.calculations.mortgage_ids') )
    end
  end

  def show
    @calculation = Calculation.find(params[:id])
    authorize! :read, @calculation
  end

  def create
    @calculation = Calculation.new(calculation_params)
    @calculation.author = current_user

    call_make_calculation if @calculation.valid?
    if @calculation.save
      redirect_to @calculation, notice: t('flash.calculations.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def fill_array_title_city
    @title_city = []
    IO.foreach("#{Dir.pwd}/data/title_city_kz") {|city | @title_city << city.rstrip}    
  end

  def call_make_calculation
    if params[:calculation][:mortgage_ids] && @calculation.valid?
      @calculation.make_calculation(params[:calculation][:mortgage_ids])
    elsif @calculation.valid?
       @calculation.make_calculation(nil)
    end
  end

  def calculation_params
    params.require(:calculation).permit(:apartment_price,
                                        :accumulation,
                                        :rental_cost,
                                        :monthly_savings,
                                        :addition_income,
                                        :addition_proof_of_income,
                                        :addition_age,
                                        :addition_pledge,
                                        :addition_operating_loans,
                                        :addition_city,
                                        :enable_default_initial_fee,
                                        :enable_default_mortgage_term,
                                        :addition_mortgage_term,
                                        :addition_initial_fee,                                        
                                        addition_bank: [],                                      
                                        mortgage_ids: [],
                                        addition_type_of_housing: [])
  end 
end
