require 'rails_helper'

RSpec.describe Event, :type => :model do
	context "Test basic DB methods" do
        before :each do
            Event.create(
                :title => 'Films on Furnald: The Lion King', 
                :category => "culture", :organizer => "Film Society", 
                :location => "Furnald Lawn", 
                :start_time => DateTime.parse('3rd Feb 2001 04:05:06')
            )
            Event.create(
                :title => 'CS Coffee Chat', 
                :category => "fun", :organizer => "CS department", 
                :location => " Mudd"
            )
            @events = Event.all
        end

        it 'find event with a given title' do
            event = Event.find_by(title: 'CS Coffee Chat')
            expect(event.category).to eq('fun')
        end
    end
end
