class MortgagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  authorize_resource

  before_action :load_mortgage, only: [:show, :edit, :update, :destroy]

  def index
    @mortgages = Mortgage.all
  end

  def show
    @condition = Condition.new
  end

  def new
    @mortgage = Mortgage.new
  end

  def edit
  end

  def create
    @mortgage = Mortgage.new(mortgage_params)
    
    if @mortgage.save
      redirect_to @mortgage, notice: 'Mortgage create successfully'     
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @mortgage.title_banks_partners.clear unless mortgage_params.include?(:title_banks_partners)
    if @mortgage.update(mortgage_params)
      redirect_to @mortgage, notice: 'Mortgage update successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mortgage.destroy
    redirect_to mortgages_path, notice: 'Mortgage delete successfully' 
  end

  private
  def load_mortgage
    @mortgage = Mortgage.find(params[:id])
  end

  def mortgage_params
    params.require(:mortgage).permit(:title, 
                                     :description, 
                                     :type_mortgage, 
                                     title_banks_partners: [])
  end
end
