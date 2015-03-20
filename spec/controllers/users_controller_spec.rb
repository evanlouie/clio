require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }
  let(:another_user) {create(:user)}

  before do
    sign_in user
  end

  describe "GET index" do

    describe 'html' do
      before { get :index }
      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end

    describe 'json' do
      before {get :index, format: :json}
      it 'responds with @users as json' do
        response.body.should == [user].to_json
      end
    end
  end

  describe 'GET #status' do
    it 'responds with @users as json' do
      get :status, {format: :json, id: user.id}
      response.body.should == user.to_json(:only => [:id, :status], :methods => [:full_name])
    end
  end

  describe 'GET #show' do

    describe 'html' do
      it 'responds with html view' do
        get :show, {id: user.id}
        expect(response).to render_template('show')
      end
    end

    describe 'json' do
      it 'responds with @user.to_json' do
        get :show, {format: :json, id: user.id}
        response.body.should == user.to_json
      end
    end
  end

  describe 'GET #update' do

    describe 'HTML' do
      describe 'trying to modify another user' do
        it 'redirects to users_path' do
          put :update, {id: another_user.id, first_name: 'foo'}
          flash[:alert].size.should > 0
        end
      end
      it 'redirects to users_path' do
        get :update, {id: user.id}
        expect(response).to redirect_to(users_path)
      end
    end

    describe 'JSON' do
      it 'returns the updated user object as json' do
        get :update, {format: :json, id: user.id}
        response.body.should == user.to_json
      end
    end
  end

end
