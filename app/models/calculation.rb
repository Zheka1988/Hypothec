class Calculation < ApplicationRecord
  INITIAL_FEE = [20, 30, 40, 50]
  MORTGAGE_TERM = [5, 10, 15, 20, 25]

  belongs_to :author, class_name: "User", foreign_key: :author_id, optional: true

  validates :apartment_price,
            :accumulation,
            :rental_cost,
            :monthly_savings, presence: true

  def make_calculation(mortgage_ids)
    create_hash_for_calculated_values(mortgage_ids)
    fill_hash_with_initial_data

    calculation_for_annuity_payments
  end

  private

  def create_hash_for_calculated_values(mortgage_ids)

    unless mortgage_ids
      mortgage_ids = []
      Mortgage.all.each do |mortgage|
        mortgage_ids << mortgage.id
      end
    end

    self.mortgage_ids = mortgage_ids

    mortgage_ids.each do |id|
      self.calculated_values[id.to_s] = {
        an_initial_fee: {}, rental_period: {}, sum_rental_costs: {},
        mortgage_term: {}, monthly_payment: {}, overpayment: {},
        lost_money: {}, full_term: {}, mortgage_ids: [],
        interest_rate: {}
      }
    end
  end 
  
  def fill_hash_with_initial_data
    self.mortgage_ids.each do |id|
      @mortgage = Mortgage.find(id)
      if @mortgage && @mortgage.condition
        @mortgage.condition.attribute_names.each do |name|
          if name.include?('value_interest_rate_') && @mortgage.condition.send(name)
           self.calculated_values[id.to_s][:interest_rate][name.to_sym] = @mortgage.condition.send(name)
           self.calculated_values[id.to_s][:an_initial_fee][name.to_sym] = []
           self.calculated_values[id.to_s][:rental_period][name.to_sym] = []
           self.calculated_values[id.to_s][:sum_rental_costs][name.to_sym] = []
           self.calculated_values[id.to_s][:mortgage_term][name.to_sym] = []
           self.calculated_values[id.to_s][:monthly_payment][name.to_sym] = {}
           self.calculated_values[id.to_s][:overpayment][name.to_sym] = {}
           self.calculated_values[id.to_s][:lost_money][name.to_sym] = {}
           self.calculated_values[id.to_s][:full_term][name.to_sym] = {}
          end 
        end
      end
      additional_conditions(id)
    end
  end


  def additional_conditions(id)
    condition_mortgage_term_and_initial_fee(id)
  end

  def condition_mortgage_term_and_initial_fee(id)
    self.calculated_values[id.to_s][:interest_rate].each do |title_interest_rate, value|
      if self.enable_default_initial_fee
        self.calculated_values[id.to_s][:an_initial_fee][title_interest_rate] = INITIAL_FEE
        self.calculated_values[id.to_s][:an_initial_fee][title_interest_rate] += self.addition_initial_fee.split(',').map(&:to_i) if self.addition_initial_fee
      else
        self.calculated_values[id.to_s][:an_initial_fee][title_interest_rate] = self.addition_initial_fee.split(',').map(&:to_i) if self.addition_initial_fee
      end

      if self.enable_default_mortgage_term
        self.calculated_values[id.to_s][:mortgage_term][title_interest_rate] = MORTGAGE_TERM
        self.calculated_values[id.to_s][:mortgage_term][title_interest_rate] += self.addition_mortgage_term.split(',').map(&:to_i) if self.addition_initial_fee

      else
        self.calculated_values[id.to_s][:mortgage_term][title_interest_rate] = self.addition_mortgage_term.split(',').map(&:to_i) if self.addition_initial_fee
      end

      self.calculated_values[id.to_s][:an_initial_fee][title_interest_rate].sort!
      self.calculated_values[id.to_s][:mortgage_term][title_interest_rate].sort!
    end
  end

  def calculation_for_annuity_payments
    self.calculated_values.each do |mortgage_id, hash_data|
      
      hash_data[:interest_rate].each do |title_interest_rate, percent|
        monthly_interest_rate = percent / 12 / 100
        
        self.calculated_values[mortgage_id][:an_initial_fee][title_interest_rate].each do |initial_fee|
          self.calculated_values[mortgage_id][:monthly_payment][title_interest_rate][initial_fee] = []
          self.calculated_values[mortgage_id][:overpayment][title_interest_rate][initial_fee] = []
          self.calculated_values[mortgage_id][:lost_money][title_interest_rate][initial_fee] = []
          self.calculated_values[mortgage_id][:full_term][title_interest_rate][initial_fee] = []

          summ_initial_fee = self.apartment_price / 100 * initial_fee
          summ_mortgage = self.apartment_price - summ_initial_fee
          
          rental_period = (summ_initial_fee - self[:accumulation]) / self[:monthly_savings]
          self.calculated_values[mortgage_id][:rental_period][title_interest_rate] << rental_period
          
          sum_rental_cost = rental_period * self.rental_cost
          self.calculated_values[mortgage_id][:sum_rental_costs][title_interest_rate] << sum_rental_cost

          self.calculated_values[mortgage_id][:mortgage_term][title_interest_rate].each do |term|
            total_rate = (1 + monthly_interest_rate) ** (term * 12)
            
            monthly_payment = (summ_mortgage * monthly_interest_rate * total_rate / (total_rate - 1)).round
            self.calculated_values[mortgage_id][:monthly_payment][title_interest_rate][initial_fee] << monthly_payment
            
            overpayment = monthly_payment * term * 12 - summ_mortgage
            self.calculated_values[mortgage_id][:overpayment][title_interest_rate][initial_fee] << overpayment
            self.calculated_values[mortgage_id][:lost_money][title_interest_rate][initial_fee] << overpayment + sum_rental_cost
            self.calculated_values[mortgage_id][:full_term][title_interest_rate][initial_fee] << rental_period + term * 12
          end
        end
      end      
    end
  end
end
