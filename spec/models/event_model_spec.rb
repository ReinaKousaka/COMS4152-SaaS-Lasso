require 'rails_helper'

RSpec.describe Event, :type => :model do

    context 'Events model basics' do 
        let!(:user1) { FactoryGirl.create(:user) }
        before :each do 
            Event.delete_all 
            Event.create({
                :title => 'Films on Furnald: The Lion King',
                :category => "culture",
                :user_id => 1,
                :location => "Furnald Lawn", 
                :start_time => DateTime.parse('30th October 20:00:00'),
                :end_time => DateTime.parse('30th October 22:00:00')
            })
            Event.create({
                :title => 'CS Coffee Chat',
                :category => "academic",
                :user_id => 1,
                :location => "CS Lounge", 
                :start_time => DateTime.parse('28th October 14:00:00'),
                :end_time => DateTime.parse('28th October 16:00:00')
            })

            Event.create({
                :title => 'Halloween Party',
                :category => "fun",
                :user_id => 1,
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

        

        describe 'event does not exist' do
            it 'handles sad path' do
              expect(Event.find_by(title: 'Thanks Giving')).to eql(nil)
            end
        end


    end
end
