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
                :user_id => 1,
                :location => "Furnald Lawn", 
                :start_time => DateTime.parse('30th November 20:00:00'),
                :end_time => DateTime.parse('30th November 22:00:00')
            })
            Event.create({
                :title => 'CS Coffee Chat',
                :category => "academics", 
                :organizer => "CS department", 
                :user_id => 1,
                :location => " CS Lounge", 
                :start_time => DateTime.parse('1st November 14:00:00'),
                :end_time => DateTime.parse('1st November 15:00:00')
            })
            @events = Event.all
        end

        describe 'POST #create' do
            it 'Should be create a event' do
                events_count = Event.all.count
                event = {
                    :title => 'Varsity Football vs. UPenn', 
                    :category => 'athletics', 
                    :organizer => 'Varisty Football', 
                    :user_id => 1,
                    :location => 'Baker Stadium', 
                    :start_time => DateTime.parse('13th November 15:00:00'),
                    :end_time => DateTime.parse('13th November 19:00:00')
                }

                get :create, event: event

                expect(flash[:notice]).to eq("Event '#{event[:title]}' was successfully created.")
                expect(response).to redirect_to(events_path)
                expect(@events.count).to eq(events_count + 1)
            end
        end

        describe 'DELETE #destroy' do 
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

        describe 'GET #edit' do
            let!(:event) { FactoryGirl.create(:event) }
            before do
                get :edit, id: event.id
            end
        
            it 'should find the movie' do
                expect(assigns(:event)).to eql(event)
            end
        
            it 'should render the edit template' do
                expect(response).to render_template('edit')
            end
        end

        describe 'PUT #update' do
            let(:event1) { FactoryGirl.create(:event) }
            before(:each) do
                put :update, id: event1.id, event: FactoryGirl.attributes_for(:event, category: 'culture')
            end

            it 'updates an existing movie' do
                event1.reload
                expect(event1.category).to eql('culture')
            end

            it 'redirects to the main page' do
                expect(response).to redirect_to(events_path(event1))
                expect(flash[:notice]).to eq("Event '#{event1[:title]}' was successfully updated.")
            end
        end


        describe 'GET #show' do
            let!(:event) { FactoryGirl.create(:event) }
            before(:each) do
                get :show, id: event.id
            end
        
            it 'should find the event' do
                expect(assigns(:event)).to eql(event)
            end
        
            it 'should render the show template' do
                expect(response).to render_template('show')
            end
        end

        describe 'GET index' do
            let!(:event) { FactoryGirl.create(:event) }
        
            it 'should return all events if no categories selected and no sort by' do 
                get :index

                assert_response :success
                response.should render_template('index')

                expect(@categories_to_show_hash).to eq(nil)
                expect(@sort_by).to eq(nil)
                expect(session['categories']).to eq(["athletics", "academics", "career", "culture", "fun"])
                expect(session['sort_by']).to eq('id')
                expect(@events.count).to eq(Event.all.count)
                expect(@events.first).to eq(Event.first)
            end

            it 'should assign instance variable for title header' do
              get :index, { sort: 'start_time'}
              expect(event.title).to eql('CS Coffee Chat')
            end
        
            it 'should assign instance variable for release_date header' do
              get :index, { sort: 'organizer'}
              expect(event.title).to eql('CS Coffee Chat')
            end
        end
          
    end
end
