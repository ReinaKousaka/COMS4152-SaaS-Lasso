require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    context '#new' do
        it 'render new template' do
            get :new
            expect(response).to render_template("new")
        end   
    end

    context 'Events page basic methods' do
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
                :category => "academics", 
                :organizer => "CS department", 
                :location => " CS Lounge", 
                :start_time => DateTime.parse('1st November 14:00:00'),
                :end_time => DateTime.parse('1st November 15:00:00')
            })
            @events = Event.all
        end

        describe '.create a new event' do
            it 'Should be create a event' do
                events_count = Event.all.count
                event = {
                    :title => 'Varsity Football vs. UPenn', 
                    :category => 'athletics', 
                    :organizer => 'Varisty Football', 
                    :location => 'Baker Stadium', 
                    :start_time => DateTime.parse('13th November 15:00:00'),
                    :end_time => DateTime.parse('13th November 19:00:00')
                }

                get :create, event: event

                expect(flash[:notice]).to eq("Event '#{event[:title]}' was successfully created.")
                expect(response).to redirect_to(events_path)
                expect(@events.count).to eq(events_count + 1)
                expect(flash[:notice]).to eq("Event '#{event[:title]}' was successfully created.")
            end
        end

        describe 'deleting event' do 
            it 'event that is deleted should not appear' do 
                event = @events.take
                original_events_count = Event.all.count       
                
                delete :destroy, id: event.id
                expect(Event.find_by_title("Films on Furnald: The Lion King")). to eq(nil)
                expect(response).to redirect_to events_path
                expect(@events.count).to eq(original_events_count - 1)
                expect(flash[:notice]).to eq ("Event 'Films on Furnald: The Lion King' deleted.")
            end
        end
    end
end
