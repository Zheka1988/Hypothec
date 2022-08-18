require 'rails_helper'

RSpec.describe MortgagesController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:mortgage) { create(:mortgage) }
  
  describe 'GET #index' do
    let(:mortgages) { create_list(:mortgage, 3) }

    before { get :index }

    it 'populates an array of all mortgages' do
      expect(assigns(:mortgages)).to match_array(mortgages)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: mortgage } }
      
    it 'assigns the requested mortgage to @mortgage' do  
      expect(assigns(:mortgage)).to eq mortgage
    end
      
    it 'assigns new condition for mortgage' do
      expect(assigns(:condition)).to be_a_new(Condition)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'as admin' do
      before { login(admin) }
      before { get :new }

      it 'assigns the requested mortgage to @mortgage' do
        expect(assigns(:mortgage)).to be_a_new(Mortgage)
      end

      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    context 'as not admin' do
      before { login(user) }
      before { get :new }
      
      it 'atempt assigns the requested mortgage to @mortgage' do
        expect(assigns(:mortgage)).to_not be_a_new(Mortgage)
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'As admin' do
      before { login(admin) }
      
      context 'with valid attributes' do
        it 'saves a new mortgage in the database' do
          expect { post :create, params: { mortgage: attributes_for(:mortgage) } }.to change(Mortgage, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { mortgage: attributes_for(:mortgage) }
          expect(response).to redirect_to assigns(:mortgage)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the mortgage' do
          expect { post :create, params: { mortgage: attributes_for(:mortgage, :invalid) } }.to_not change(Mortgage, :count)
        end

        it 're-renders new view' do
          post :create, params: { mortgage: attributes_for(:mortgage, :invalid) }
          expect(response).to render_template :new
        end     
      end
    end

    context 'As not admin' do
      before { login(user) }

      it 'does not save the mortgage' do
        expect { post :create, params: { mortgage: attributes_for(:mortgage) } }.to_not change(Mortgage, :count)
      end

      it 'rendirect to root_path' do
        post :create, params: { mortgage: attributes_for(:mortgage) }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
    context 'as admin' do
      before { login(admin) }
      before { get :edit, params: { id: mortgage } }

      it 'assigns the requested mortgage to @mortgage' do  
        expect(assigns(:mortgage)).to eq mortgage
      end
        
      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'as not admin' do
      before { login(user) }
      before { get :edit, params: { id: mortgage } }
      
      it 'atempt assigns the requested mortgage to @mortgage' do
        expect(assigns(:mortgage)).to eq nil
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to root_path
      end      
    end
  end

  describe 'PATCH #update' do
    context 'As admin' do
      before { login(admin) }

      context 'with valid attributes' do
        it 'assigns the requested mortgage to @mortgage' do
          patch :update, params: { id: mortgage, mortgage: attributes_for(:mortgage) }  
          expect(assigns(:mortgage)).to eq mortgage
        end

        it 'changes mortgage attributes' do
          patch :update, params: { id: mortgage, mortgage: { title: "new title", description: "new description" } }
          mortgage.reload

          expect(mortgage.title).to eq "new title"
          expect(mortgage.description).to eq "new description"
        end

        it 'redirects to updated mortgage' do
          patch :update, params: { id: mortgage, mortgage: attributes_for(:mortgage) }
          expect(response).to redirect_to mortgage 
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: mortgage, mortgage: attributes_for(:mortgage, :invalid) } }
        
        it 'does not save the mortgage' do
          mortgage.reload

          expect(mortgage.title).to eq "MyString"
          expect(mortgage.description).to eq "MyText"
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end 
      end
    end

    context 'As not admin' do
      before { login(user) }

      it 'does not save the mortgage' do
        patch :update, params: { id: mortgage, mortgage: { title: "new title", description: "new description" } }
        mortgage.reload

        expect(mortgage.title).to eq "MyString"
        expect(mortgage.description).to eq "MyText"
      end

      it 'rendirect to root_path' do
        post :update, params: { id: mortgage, mortgage: attributes_for(:mortgage) }
        expect(response).to redirect_to root_path
      end      
    end
  end

  describe 'DELETE #destroy' do
    let!(:mortgage) { create(:mortgage) }

    context 'As admin' do
      before { login(admin) }
      
      
      it 'deletes the mortgage' do
        expect { delete :destroy, params: { id: mortgage } }.to change(Mortgage, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: mortgage }
        expect(response).to redirect_to mortgages_path
      end
    end

    context 'As not admin' do
      before { login(user) }

      it 'not deletes the mortgage' do
        expect { delete :destroy, params: { id: mortgage } }.to_not change(Mortgage, :count)
      end

      it 'rendirect to root_path' do
        post :update, params: { id: mortgage, mortgage: attributes_for(:mortgage) }
        expect(response).to redirect_to root_path
      end   
    end
  end  
end
