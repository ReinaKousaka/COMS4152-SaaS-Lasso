require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:each) do
        # set up HTTP_REFERER to an actual URL and then expect to be redirected back
        request.env['HTTP_REFERER'] = '/register'
    end

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
                :organizer_name => 'organizer1',
                :password => 'password'
            }

            post :create, user: user
            
            expect(User.all.count).to eq(1)
            expect(session[:user_id]).to eq(1)
            expect(response).to redirect_to(root_path)
        end

        it 'failed to create new users because empty information' do
            expect(User.all.count).to eq(0)

            user = {
                :email => 'user1@columbia.edu',
                :organizer_name => '',
                :password => 'password'
            }

            post :create, user: user

            expect(User.all.count).to eq(0)
            expect(flash[:danger]).to eq('Account information fields cannot be empty.')
            expect(response).to redirect_to('/register')
        end

        it 'failed to create new users because password is too short' do
            expect(User.all.count).to eq(0)

            user = {
                :email => 'user1@columbia.edu',
                :organizer_name => 'organizer1',
                :password => '1234'
            }

            post :create, user: user

            expect(User.all.count).to eq(0)
            expect(flash[:danger]).to eq('Password is too short!')
            expect(response).to redirect_to('/register')
        end

        it 'failed to create new users because duplicate of emails' do
            expect(User.all.count).to eq(0)

            user = {
                :email => 'user1@columbia.edu',
                :organizer_name => 'organizer1',
                :password => 'password'
            }

            post :create, user: user
            expect(User.all.count).to eq(1)

            post :create, user: {
                :email => 'user1@columbia.edu',
                :organizer_name => 'organizer2',
                :password => 'password2'
            }
            expect(User.all.count).to eq(1)
            expect(flash[:danger]).to eq('Email has already been taken')
            expect(response).to render_template('new')
        end
    end
end