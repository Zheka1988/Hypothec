class ConditionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  authorize_resource
  
  before_action :set_mortgage, only: [:create]
  before_action :load_condition, only: [:destroy, :update, :edit]
  
  def create
    @condition = @mortgage.build_condition(condition_params)
    if @condition.save
      redirect_to @mortgage, notice: 'Conditions create successfully'
    else
      render 'mortgages/show', status: :unprocessable_entity
    end
  end

  def edit
  end
  
  def update
    if @condition.update(condition_params)
      redirect_to @condition.mortgage, notice: 'Condition update successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mortgage = @condition.mortgage
    @condition.destroy
    redirect_to @mortgage, status: :see_other, notice: 'Condition delete successfully'   
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
                                      :type_of_housing,
                                      :value_interest_rate_with_commision,
                                      :value_interest_rate_without_commision,
                                      :value_interest_rate_with_proof_of_income,
                                      :value_interest_rate_without_proof_of_income,
                                      :value_interest_rate_with_commision_with_proof_of_income,
                                      :value_interest_rate_with_commision_without_proof_of_income,
                                      :value_interest_rate_without_commision_with_proof_of_income,
                                      :value_interest_rate_without_commision_without_proof_of_income,
                                      :value_interest_rate_for_payroll_project,
                                      :value_max_loan_amount,
                                      :value_max_loan_term,
                                      :value_max_age,
                                      :value_min_an_initial_fee,
                                      :value_max_an_initial_fee,
                                      :value_income,
                                      :value_loan_processing_fee,
                                      :value_application_fee,
                                      :value_arly_redemption_fee,
                                      :additional_expenses,
                                      :value_additional_expenses,
                                      :pledge,
                                      :insurance,
                                      :value_insurance)
  end
end
