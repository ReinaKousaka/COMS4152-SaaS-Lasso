# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

events = [{:title => 'Films on Furnald: The Lion King', :category => "culture", :organizer => "Film Society", :location => "Furnald Lawn", :start_time => '25-Nov-1992'},

  	 ]

events.each do |event|
  Event.create!(event)
end
