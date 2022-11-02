require 'rails_helper'

RSpec.describe Event, :type => :model do
	# context "Test basic DB methods" do
    #     before :each do
    #         Event.create(
    #             :title => 'Films on Furnald: The Lion King', 
    #             :category => "culture", :organizer => "Film Society", 
    #             :location => "Furnald Lawn", 
    #             :start_time => DateTime.parse('3rd Feb 2001 04:05:06')
    #         )
    #         Event.create(
    #             :title => 'CS Coffee Chat', 
    #             :category => "fun", :organizer => "CS department", 
    #             :location => " Mudd"
    #         )
    #         @events = Event.all
    #     end

    #     it 'find event with a given title' do
    #         event = Event.find_by(title: 'CS Coffee Chat')
    #         expect(event.category).to eq('fun')
    #     end
    # end

    # context 'Events page basic methods' do
    #     before :each do
    #         Event.delete_all
    #         Event.create({
    #             :title => 'Films on Furnald: The Lion King', 
    #             :category => "culture", 
    #             :organizer => "Film Society", 
    #             :location => "Furnald Lawn", 
    #             :start_time => DateTime.parse('30th October 20:00:00'),
    #             :end_time => DateTime.parse('30th October 22:00:00')
    #         })
    #         @events = Event.all
    #     end

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
                expect(interested_events.count).to eq(2)
            end 
        end

    end


end
