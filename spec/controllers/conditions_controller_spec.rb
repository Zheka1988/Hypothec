require 'rails_helper'

RSpec.describe ConditionsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  let(:mortgage) { create :mortgage }
  let(:condition) { create :condition, mortgage: mortgage }

  describe 'POST #create' do
    context 'As admin' do
      before { login(admin) }

      context 'with valid attributes' do
        it 'saves a new condition in the database' do
          expect { post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition) } }.to change(Condition, :count).by(1)
        end
        
        it 'the condition is related to the mortgage' do
          post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition) }
          expect(assigns(:condition).mortgage_id).to eq mortgage.id
        end

        it 'redirect to show mortgage view' do
          post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition) }
          expect(response).to redirect_to assigns(:mortgage)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the condition' do
          expect { post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition, :invalid) } }.to_not change(Condition, :count)
        end
        
        it 'render to show mortgage view' do
          post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition, :invalid) }
          expect(response).to render_template 'mortgages/show'
        end
      end
    end

    context 'As not admin' do
      before { login(user) }
      
      it 'does not save the condition' do
        expect { post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition) } }.to_not change(Condition, :count)
      end

      it 'rendirect to root_path' do
        post :create, params: { mortgage_id: mortgage, condition: attributes_for(:condition) }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:condition) { create :condition, mortgage: mortgage }
    
    it 'deletes the condition' do
      expect { delete :destroy, params: { id: condition } }.to change(Condition, :count).by(-1)  
    end

    it 'render to show' do
      delete :destroy, params: { id: condition }
      expect(response).to redirect_to condition.mortgage
    end
  end

  describe 'PATH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'assigns the requested condition to @condition' do
        patch :update, params: { id: condition, condition: attributes_for(:condition) }
        expect(assigns(:condition)).to eq condition
      end

      it 'changes condition attributes' do
        patch :update, params: { id: condition, condition: { interest_rate: '123', max_loan_amount: '321' } }
        condition.reload

        expect(condition.interest_rate).to eq '123'
        expect(condition.max_loan_amount).to eq '321'
      end

      it 'redirects to updated mortgage' do
        patch :update, params: { id: condition, condition: attributes_for(:condition) }
        expect(response).to redirect_to condition.mortgage
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: condition, condition: attributes_for(:condition, :invalid) } }
      
      it 'does not save the condition' do
        condition.reload
        expect(condition.interest_rate).to eq "MyString_Interest_Rate"
        expect(condition.max_loan_amount).to eq "MyString"
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end  
    end
  end
end
