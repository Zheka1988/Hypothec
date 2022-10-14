require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:not_author) { create :user }

  let(:mortgage) { create :mortgage }
  let!(:mortgages) { create_list :mortgage, 3 }
  let(:condition) { create :condition, mortgage: mortgage }
  let(:calculation) { create :calculation, mortgage_ids: [mortgage.id], author: user }

  describe 'GET #index' do
    let!(:calculation1) { create :calculation, mortgage_ids: [mortgage.id], author: user }
    let!(:calculation2) { create :calculation, mortgage_ids: [mortgage.id], author: user }
    let!(:calculation3) { create :calculation, mortgage_ids: [mortgage.id], author: not_author }
    
    context 'Authenticated user' do
      context 'As admin' do
        before { login(admin) }
        before { get :index }

        it 'assigns the requested all calculations to @calculations' do
          expect(assigns(:calculations).count).to eq 3 
        end

        it 'render index view' do
          expect(response).to render_template :index
        end
      end

      context 'As author' do
        before { login(user) }
        before { get :index }

        it 'assigns the requested calculations (only author) to @calculations' do
          expect(assigns(:calculations).count).to eq 2
          expect(assigns(:calculations).first.author).to eq user
          expect(assigns(:calculations).second.author).to eq user 
        end

        it 'render index view' do
          expect(response).to render_template :index
        end                
      end
    end

    context 'Unauthenticated user' do
      before { get :index }
      
      it 'not assigns the requested calculations (only author) to @calculations' do
        expect(assigns(:calculations)).to eq nil
      end

      it 'redirect to page sign_in' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #new' do
    context 'Authenticated user' do
      context 'As admin' do
        before { login(admin) }
        before { get :new }

        it 'assigns the requested calculation to @calculation' do
          expect(assigns(:calculation)).to be_a_new(Calculation)
        end

        it 'render new view' do
          expect(response).to render_template :new
        end
      end

      context 'As not admin' do
        before { login(user) }
        before { get :new }

        it 'assigns the requested calculation to @calculation' do
          expect(assigns(:calculation)).to be_a_new(Calculation)
        end

        it 'render new view' do
          expect(response).to render_template :new
        end
      end
    end
    context 'Unauthenticated user' do
      before { get :new }

      it 'assigns the requested calculation to @calculation' do
        expect(assigns(:calculation)).to be_a_new(Calculation)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context 'Authenticated user' do
      context 'As admin' do
        before { login(admin) }
        
        context 'with valid attributes' do
          it 'saves a new calculation in the database for selected mortgages' do
            expect { post :create, params: { calculation: attributes_for(:calculation, mortgage_ids: [mortgages.first.id, mortgages.last.id]) } }.to change(Calculation, :count).by(1)
            expect(assigns(:calculation).calculated_values.keys.count).to eq 2          
          end

          it 'saves a new calculation in the database for all mortgages' do
            expect { post :create, params: { calculation: attributes_for(:calculation) } }.to change(Calculation, :count).by(1)
            expect(assigns(:calculation).calculated_values.keys.count).to eq 3
          end

          it 'redirects to show view' do
            post :create, params: { calculation: attributes_for(:calculation) }
            expect(response).to redirect_to assigns(:calculation)
          end
        end

        context 'with invalid attributes' do
          it 'does not save the calculation' do
            expect { post :create, params: { calculation: attributes_for(:calculation, :invalid) } }.to_not change(Calculation, :count)
          end
          
          it 're-renders new view' do
            post :create, params: { calculation: attributes_for(:calculation, :invalid) }
            expect(response).to render_template :new
          end
        end
      end

      context 'As not admin' do
        before { login(user) }

        context 'with valid attributes' do
          it 'saves a new calculation in the database' do
            expect { post :create, params: { calculation: attributes_for(:calculation) } }.to change(Calculation, :count).by(1)
          end

          it 'redirects to show view' do
            post :create, params: { calculation: attributes_for(:calculation) }
            expect(response).to redirect_to assigns(:calculation)
          end
        end

        context 'with invalid attributes' do
          it 'does not save the calculation' do
            expect { post :create, params: { calculation: attributes_for(:calculation, :invalid) } }.to_not change(Calculation, :count)
          end
          
          it 're-renders new view' do
            post :create, params: { calculation: attributes_for(:calculation, :invalid) }
            expect(response).to render_template :new
          end
        end
      end
    end
    
    context 'Unauthenticated user' do
      context 'with valid attributes' do
        it 'saves a new calculation in the database' do
          expect { post :create, params: { calculation: attributes_for(:calculation) } }.to change(Calculation, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { calculation: attributes_for(:calculation) }
          expect(response).to redirect_to assigns(:calculation)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the calculation' do
          expect { post :create, params: { calculation: attributes_for(:calculation, :invalid) } }.to_not change(Calculation, :count)
        end
        
        it 're-renders new view' do
          post :create, params: { calculation: attributes_for(:calculation, :invalid) }
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET #show' do
    context 'Authenticated user' do
      context 'As admin' do
        before { login(admin) }
        before { get :show, params: { id: calculation } }
          
        it 'assigns the requested calculation to @calculation' do  
          expect(assigns(:calculation)).to eq calculation
        end
          
        it 'render show view' do
          expect(response).to render_template :show
        end
      end

      context 'As not admin' do
        before { login(user) }
        before { get :show, params: { id: calculation } }
          
        it 'assigns the requested calculation to @calculation' do  
          expect(assigns(:calculation)).to eq calculation
        end
          
        it 'render show view' do
          expect(response).to render_template :show
        end
      end
    end

    context 'Unauthenticated user' do
      # before { get :show, params: { id: calculation } }
        
      it 'assigns the requested calculation to @calculation' #do  
      #   expect(assigns(:calculation)).to eq calculation
      # end
        
      it 'render show view' #do
      #   expect(response).to render_template :show
      # end     
    end
  end
end
