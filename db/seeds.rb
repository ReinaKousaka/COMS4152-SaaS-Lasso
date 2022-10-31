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
        :start_time => DateTime.parse('30th October 20:00:00'),
        :end_time => DateTime.parse('30th October 22:00:00')
    },
    {
        :title => 'CS Coffee Chat', 
        :category => "fun", 
        :organizer => "CS department", 
        :location => " CS Lounge", 
        :start_time => DateTime.parse('1st November 14:00:00'),
        :end_time => DateTime.parse('1st November 15:00:00')
    },
    {
        :title => 'Undergraduate Holiday Bash', 
        :category => 'fun' , 
        :organizer => "Undergraduate Student Life", 
        :location => "John Jay Lounge", 
        :start_time => DateTime.parse('2nd December 18:00:00'),
        :end_time => DateTime.parse('2nd December 23:30:00')
    },
    {
        :title => 'Networking Roundtable in Finance', 
        :category => 'career', 
        :organizer => 'CCE', 
        :location => 'Lerner Audiotorium', 
        :start_time => DateTime.parse('15th November 14:00:00'),
        :end_time => DateTime.parse('15th November 17:00:00')
    },
    {
        :title => 'Varsity Football vs. UPenn', 
        :category => 'athletics', 
        :organizer => 'Varisty Football', 
        :location => 'Baker Stadium', 
        :start_time => DateTime.parse('13th November 15:00:00'),
        :end_time => DateTime.parse('13th November 19:00:00')
    }
  ]

events.each do |event|
  Event.create!(event)
end
