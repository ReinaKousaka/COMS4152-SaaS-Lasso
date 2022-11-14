module SpecTestHelper
    def login_admin
        user = FactoryGirl.create(:user, type: 0)
        session[:user_id] = user.id
    end
end
  
RSpec.configure do |config|
    config.include SpecTestHelper, type: :controller
end
