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
        :user_id => 5,
        :location => "Furnald Lawn", 
        :start_time => DateTime.parse('30th October 20:00'),
        :end_time => DateTime.parse('30th October 22:00'), 
        :description => "The Columbia University Film Society is excited to present it's fifth feature fill of the semester --- The Lion King! Come see the the Lion King on the big screen in front of Furnald lawn. There will be popcorn, drinks and other snacks for sell in support of the Arts at Columbia!"
    },
    {
        :title => 'CS Coffee Chat', 
        :category => "academics", 
        :user_id => 2,
        :location => " CS Lounge", 
        :start_time => DateTime.parse('1st November 14:00'),
        :end_time => DateTime.parse('1st November 15:00'), 
        :description => "The CS Department is hosting a coffee chat. Current and prospective students are welcome to come and speak with CS faculty, advisors, and current students! Joe's Coffee will be served. Come with questions about Spring Registration, graduation requirements, and research opportunities within the department!"
    },
    {
        :title => 'Undergraduate Holiday Bash', 
        :category => 'fun' , 
        :user_id => 5,
        :location => "John Jay Lounge", 
        :start_time => DateTime.parse('2nd December 18:00'),
        :end_time => DateTime.parse('2nd December 23:30'), 
        :description => "Theme is A Cartoon Christmas! Come celebrate with undergraduate students across Columbia!"
    },
    {
        :title => 'Networking Roundtable in Finance', 
        :category => 'career', 
        :user_id => 4,
        :location => 'Lerner Audiotorium', 
        :start_time => DateTime.parse('15th November 14:00'),
        :end_time => DateTime.parse('15th November 17:00'), 
        :description => "Employers including Silverperson Trumpets, Three Alpha, and East River Exchange will be speaking!"
    },
    {
        :title => 'Varsity Football vs. UPenn', 
        :category => 'athletics',
        :user_id => 3, 
        :location => 'Baker Stadium', 
        :start_time => DateTime.parse('13th November 15:00'),
        :end_time => DateTime.parse('13th November 19:00'), 
        :description => "Home game against the Quakers! Come out and support."
    },
    {
        :title => 'Finals Scream', 
        :category => 'fun',
        :user_id => 5, 
        :location => 'Low Steps', 
        :start_time => DateTime.parse('21st December 20:00'),
        :end_time => DateTime.parse('21st December 20:30'), 
        :description => "Scream your lungs out to destress during finals. Let's shatter last year's decibel record!"
    },
    {
        :title => 'Womens Basketball vs. UConn', 
        :category => 'athletics',
        :user_id => 3, 
        :location => 'Levain Gymansium', 
        :start_time => DateTime.parse('23rd December 13:00'),
        :end_time => DateTime.parse('23rd December 17:00'), 
        :description => "Home game against the Huskies! Come out and support."
    },
    {
        :title => 'Graduate Students Research Presentation', 
        :category => 'academics',
        :user_id => 2, 
        :location => 'Low Rotunda', 
        :start_time => DateTime.parse('28th December 10:00'),
        :end_time => DateTime.parse('28t December 13:00'), 
        :description => "Selected PhD and Masters students will present their original research. Hors d'oeuvre will be provided."
    },
    {
        :title => 'Picnic in the Park', 
        :category => 'fun',
        :user_id => 5, 
        :location => 'Riverside Park', 
        :start_time => DateTime.parse('30th December 11:00'),
        :end_time => DateTime.parse('30th December 13:00'), 
        :description => "Bring your own food to hang in Riverside!"
    },
    {
        :title => 'Undergraduate Students Research Presentation', 
        :category => 'academics',
        :user_id => 2, 
        :location => 'Low Rotunda', 
        :start_time => DateTime.parse('29th December 16:00'),
        :end_time => DateTime.parse('29th December 18:00'), 
        :description => "Selected BA and BS students will present their original research. Hors d'oeuvre will be provided."
    },
    {
        :title => 'Campus Open Mic', 
        :category => 'fun',
        :user_id => 5, 
        :location => 'South Lawn', 
        :start_time => DateTime.parse('14th December 20:00'),
        :end_time => DateTime.parse('14th December 22:30'), 
        :description => "Join us on the lawn to see your talent fellow Columbians share their art."
    }
]

users = [
    {
        :email => 'admin@lasso.com',
        :organizer_name => 'admin',
        :password_digest => BCrypt::Password.create('admin'),
        :description => "We are the Lasso team and we want to connect the Columbia community through events!"
    }, 
    {
        :email => 'cs@lasso.com',
        :organizer_name => 'cs department',
        :password_digest => BCrypt::Password.create('admin123')
    },
    {
        :email => 'athletics@lasso.com',
        :organizer_name => 'Columbia Athletics',
        :password_digest => BCrypt::Password.create('password')
    },
    {
        :email => 'cce@lasso.com',
        :organizer_name => 'Center for Career Education',
        :password_digest => BCrypt::Password.create('password')
    },
    {
        :email => 'studentlife@lasso.com',
        :organizer_name => 'Undergraduate Student Life',
        :password_digest => BCrypt::Password.create('password')
    }
]

events.each do |event|
    Event.create!(event)
end

users.each do |user|
    User.create!(user)
end
