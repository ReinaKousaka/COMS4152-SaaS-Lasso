require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'GET /register' do
        it 'new' do
            get :new
            expect(response).to have_http_status(:success)
        end
    end

    describe 'POST /users' do
        it 'create new user successfully' do
            user = {
                :email => 'user1@columbia.edu',
                :username => 'user1',
                :password => 'password'
            }

            post :create, user: user
            
            expect(User.all.count).to eq(1)
            expect(session[:user_id]).to eq(1)
            expect(response).to redirect_to(root_path)
        end

        it 'failed to create new users because duplicate of emails' do
            expect(User.all.count).to eq(0)

            user = {
                :email => 'user1@columbia.edu',
                :username => 'user1',
                :password => 'password'
            }

            post :create, user: user
            expect(User.all.count).to eq(1)

            post :create, user: {
                :email => 'user1@columbia.edu',
                :username => 'user2',
                :password => 'password2'
            }
            expect(User.all.count).to eq(1)
            expect(flash[:notice]).to eq('Email has already been taken')
            expect(response).to render_template('new')
        end
    end
end