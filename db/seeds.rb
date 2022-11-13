# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'

events = [
    {
        :title => 'Films on Furnald: The Lion King', 
        :category => "culture", 
        :organizer => "Film Society",
        :location => "Furnald Lawn", 
        :start_time => DateTime.parse('30th October 20:00'),
        :end_time => DateTime.parse('30th October 22:00'), 
        :description => "The Columbia University Film Society is excited to present it's fifth feature fill of the semester --- The Lion King! Come see the the Lion King on the big screen in front of Furnald lawn. There will be popcorn, drinks and other snacks for sell in support of the Arts at Columbia!"
    },
    {
        :title => 'CS Coffee Chat', 
        :category => "academics", 
        :organizer => "CS department",
        :location => " CS Lounge", 
        :start_time => DateTime.parse('1st November 14:00'),
        :end_time => DateTime.parse('1st November 15:00'), 
        :description => "The CS Department is hosting a coffee chat. Current and prospective students are welcome to come and speak with CS faculty, advisors, and current students! Joe's Coffee will be served. Come with questions about Spring Registration, graduation requirements, and research opportunities within the department!"
    },
    {
        :title => 'Undergraduate Holiday Bash', 
        :category => 'fun' , 
        :organizer => "Undergraduate Student Life", 
        :organizer_id => 1, 
        :location => "John Jay Lounge", 
        :start_time => DateTime.parse('2nd December 18:00'),
        :end_time => DateTime.parse('2nd December 23:30'), 
        :description => "Theme is A Cartoon Christmas! Come celebrate with undergraduate students across Columbia!"
    },
    {
        :title => 'Networking Roundtable in Finance', 
        :category => 'career', 
        :organizer => 'CCE', 
        :location => 'Lerner Audiotorium', 
        :start_time => DateTime.parse('15th November 14:00'),
        :end_time => DateTime.parse('15th November 17:00'), 
        :description => "Employers including Silverperson Trumpets, Three Alpha, and East River Exchange will be speaking!"
    },
    {
        :title => 'Varsity Football vs. UPenn', 
        :category => 'athletics', 
        :organizer => 'Varisty Football', 
        :location => 'Baker Stadium', 
        :start_time => DateTime.parse('13th November 15:00'),
        :end_time => DateTime.parse('13th November 19:00'), 
        :description => ""
    }
]

users = [
    {
        :email => 'user1@columbia.edu',
        :username => 'user1',
        :password => '123456'
    }
]

events.each do |event|
    Event.create!(event)
end

users.each do |user|
    User.create!(user)
end
