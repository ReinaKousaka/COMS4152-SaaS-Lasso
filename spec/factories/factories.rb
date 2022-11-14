FactoryGirl.define do 
    factory :event do
      title                 "CS Coffee Chat"
      category              "fun"
      location              "Mudd"
      organizer             "CS department"
      user_id               1 
      start_time            DateTime.parse('30th October 20:00:00')
      end_time              DateTime.parse('30th October 22:00:00')
    end
end