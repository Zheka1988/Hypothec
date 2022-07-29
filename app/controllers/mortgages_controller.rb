class MortgagesController < ApplicationController
  before_action :load_mortgage, only: [:show, :edit, :update, :destroy]
  def index
    @mortgages = Mortgage.all
  end

  def show
  end

  def new
    @mortgage  = Mortgage.new
  end

  def edit
  end

  def create
    @mortgage = Mortgage.new(mortgage_params)

    if @mortgage.save
      redirect_to @mortgage      
    else
      render :new
    end
  end

  def update
    if @mortgage.update(mortgage_params)
      redirect_to @mortgage
    else
      render :edit
    end
  end

  def destroy
    @mortgage.destroy
    redirect_to mortgages_path
  end

  private
  def load_mortgage
    @mortgage = Mortgage.find(params[:id])
  end

  def mortgage_params
    params.require(:mortgage).permit(:title, :description)
  end
end
