require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    context '#new' do
        it 'render new template' do
            get :new
            expect(response).to render_template("new")
        end   
    end

    context 'Checking logging in features!' do
        before :each do
            User.delete_all
            User.create({
               :email => "account1@lasso.app", 
               :username => "account1", 
               :password => "123"
            }) 
            @user = User.find_by(email: "account1@lasso.app")
        end 

        describe 'Logging in w/ correct password and email!' do
            it "should correctly log in" do 
                user_params = { 
                    :email => "account1@lasso.app", 
                    :username => "account1", 
                    :password => "123"
                }
                
                get :create, user: user_params

                expect(session[:user_id]).to eq(@user.id)
                expect(response).to redirect_to(:root)    
            end 
        end 

        describe 'Logging in w/ incorrect password but registered email!' do
            it "should not log in" do 
                user_params = { 
                    :email => "account1@lasso.app", 
                    :username => "account1", 
                    :password => "1234"
                }
                
                get :create, user: user_params

                expect(flash[:notice]).to eq("Incorrect Password!")
                expect(response).to have_http_status(200)  
                expect(response).to render_template('new')
            end 
        end 

        describe 'Logging in w/ non-registered email!' do
            it "should not log in" do 
                user_params = { 
                    :email => "account1a@lasso.app", 
                    :username => "account1", 
                    :password => "1234"
                }
                
                get :create, user: user_params

                expect(flash[:notice]).to eq("The Account Does Not Exist!")
                expect(response).to have_http_status(200)  
                expect(response).to render_template('new')
            end 
        end 
    end

    context 'Checking logging out features!' do
    
        describe 'Logging out!' do
                            
            let!(:user1) { FactoryGirl.create(:user) }
            it "should correctly log out" do 
                login(user1.id)
                
                get :destroy

                expect(session[:user_id]).to eq(nil)
                expect(response).to redirect_to(:root)    
            end 
        end 
    end
end 
