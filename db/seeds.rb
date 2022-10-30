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
        :category => "culture", :organizer => "Film Society", 
        :location => "Furnald Lawn", 
        :start_time => DateTime.parse('3rd Feb 2001 04:05:06')
    }
]

events.each do |event|
  Event.create!(event)
end
