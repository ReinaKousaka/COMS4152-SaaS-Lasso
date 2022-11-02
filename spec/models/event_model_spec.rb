require 'rails_helper'

RSpec.describe Event, :type => :model do

    context 'Events model basics' do 
        before :each do 
            Event.delete_all 
            Event.create({
                :title => 'Films on Furnald: The Lion King', 
                :category => "culture", 
                :organizer => "Film Society", 
                :location => "Furnald Lawn", 
                :start_time => DateTime.parse('30th October 20:00:00'),
                :end_time => DateTime.parse('30th October 22:00:00')
            })
            Event.create({
                :title => 'CS Coffee Chat', 
                :category => "academic", 
                :organizer => "CS Department", 
                :location => "CS Lounge", 
                :start_time => DateTime.parse('28th October 14:00:00'),
                :end_time => DateTime.parse('28th October 16:00:00')
            })

            Event.create({
                :title => 'Halloween Party', 
                :category => "fun", 
                :organizer => "Social Club", 
                :location => "Lower Plaza", 
                :start_time => DateTime.parse('31th October 19:00:00'),
                :end_time => DateTime.parse('31th October 24:00:00')
            })

            
            @events = Event.all
        end 

        describe 'return all categories' do
            it 'should return all categories' do
                expect(Event.all_categories).to eq(["athletics", "academics", "career", "culture", "fun"])
            end
        end

        describe 'return events only of categories of interest' do 
            it 'should return only Films on Furnald: The Lion King if categories are culture and athletics' do 
                categories = ["culture", "athletics"]
                sort_by = "id"
                interested_events = Event.with_categories(categories, sort_by)
                expect(interested_events.count).to eq(1)
            end 
        end

        describe 'return events if no categories are selected' do 
            it 'should return all if no categories are selected' do 
                categories = nil 
                sort_by = "id"
                interested_events = Event.with_categories(categories, sort_by)
                expect(interested_events.count).to eq(3)
            end 
        end

        describe 'event does not exist' do
            it 'handles sad path' do
              expect(Event.find_by(title: 'Thanks Giving')).to eql(nil)
            end
        end


        describe 'event sort by start time' do
            it 'should return event sorted by start time' do
                sort_by = 'start_time'
                sorted_events = Event.with_sort(sort_by)
                expect(sorted_events.first).to eq(Event.find_by(title: 'CS Coffee Chat'))
                expect(sorted_events.last).to eq(Event.find_by(title: 'Halloween Party'))
            end
        end

        describe 'event sort by organizer' do
            it 'should return event sorted by Organizer' do
                sort_by = 'organizer'
                sorted_events = Event.with_sort(sort_by)
                expect(sorted_events.first).to eq(Event.find_by(title: 'CS Coffee Chat'))
                expect(sorted_events.last).to eq(Event.find_by(title: 'Halloween Party'))
            end
        end

    end



end
