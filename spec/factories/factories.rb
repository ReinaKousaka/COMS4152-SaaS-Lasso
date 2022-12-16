FactoryGirl.define do 
    factory :event do
        sequence(:title)      { |i| "Title#{i}" }
        category              "fun"
        location              "Mudd"
        user_id               1
        start_time            DateTime.parse('30th October 20:00:00')
        end_time              DateTime.parse('30th October 22:00:00')
    end

  factory :user do
    email                 "user1@columbia.edu"
    organizer_name        "organizer1"
    password_digest       "password"
  end
end