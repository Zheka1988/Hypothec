class ConditionsController < ApplicationController
  before_action :set_mortgage, only: [:create]
  before_action :load_condition, only: [:destroy, :update]

  def create
    @condition = @mortgage.build_condition(condition_params)
    if @condition.save
      redirect_to @mortgage
    else
      render :new
    end
  end

  def update
    if @condition.update(condition_params)
      redirect_to @condition.mortgage
    else
      render :edit
    end
  end

  def destroy
    @condition.destroy
    redirect_to @condition.mortgage
  end

  private
  def set_mortgage
    @mortgage = Mortgage.find(params[:mortgage_id])
  end

  def load_condition
    @condition = Condition.find(params[:id])
  end

  def condition_params
    params.require(:condition).permit(:interest_rate, 
                                      :max_loan_amount,
                                      :max_loan_term,
                                      :max_age,
                                      :income,
                                      :note,
                                      :an_initial_fee,
                                      :experience_and_registration,
                                      :type_of_housing)
  end
end
