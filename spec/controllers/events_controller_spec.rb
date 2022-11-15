require 'rails_helper'

RSpec.describe EventsController, type: :controller do
    context '#new' do
        it 'render new template' do
            get :new
            expect(response).to render_template("new")
        end   
    end

    context 'Events page basic router methods' do
        # set up HTTP_REFERER to an actual URL and then expect to be redirected back
        before(:each) do
            request.env['HTTP_REFERER'] = '/events'
        end

        describe 'POST #create' do
            let!(:user1) { FactoryGirl.create(:user) }
            let!(:event1) { FactoryGirl.create(:event) }

            it 'Create a event successfully when logged in' do
                events_count = Event.all.count
                event = {
                    :title => 'Varsity Football vs. UPenn', 
                    :category => 'athletics', 
                    :organizer => 'Varisty Football', 
                    :user_id => user1.id,
                }
                
                login(user1.id)
                get :create, event: event

                expect(flash[:notice]).to eq("Event '#{event[:title]}' was successfully created.")
                expect(response).to redirect_to(events_path)
                expect(Event.all.count).to eq(events_count + 1)
            end

            it 'Failed to create a event when NOT logged in' do
                original_events_count = Event.all.count
                event = {
                    :title => 'Varsity Football vs. UPenn', 
                    :category => 'athletics', 
                    :organizer => 'Varisty Football', 
                    :user_id => user1.id,
                }
                
                logout()
                get :create, event: event

                expect(flash[:error]).to eq("You must be logged in to access this section")
                expect(Event.all.count).to eq(original_events_count)
                response.should redirect_to '/events'
            end
        end

        describe 'DELETE #destroy' do 
            let!(:user1) { FactoryGirl.create(:user) }
            let!(:event1) { FactoryGirl.create(:event) }

            it 'Delete an event belongs to the user logged in successfully' do
                original_events_count = Event.all.count       
                
                login(user1.id)
                delete :destroy, id: event1.id
                
                expect(Event.find_by_title(event1.title)). to eq(nil)
                expect(response).to redirect_to events_path
                expect(Event.all.count).to eq(original_events_count - 1)
                expect(flash[:notice]).to eq ("Event '#{event1.title}' deleted.")
            end

            it 'Failed to delete an event when logged out' do
                original_events_count = Event.all.count
     
                logout()
                delete :destroy, id: event1.id

                expect(flash[:error]).to eq("You must be logged in to access this section")
                expect(Event.all.count).to eq(original_events_count)
                response.should redirect_to '/events'
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
            let!(:user1) { FactoryGirl.create(:user) }
            let!(:event1) { FactoryGirl.create(:event) }

            it 'Updates an existing movie when logged in successfully' do
                login(user1.id)
                put :update, id: event1.id, event: FactoryGirl.attributes_for(:event, category: 'culture')
                event1.reload
                
                expect(flash[:notice]).to eq("Event '#{event1.title}' was successfully updated.")
                expect(event1.category).to eql('culture')
                expect(response).to redirect_to(events_path(event1))
            end

            it 'Failed to update an movie when logged out' do
                original_event_category = event1.category

                logout()
                put :update, id: event1.id, event: FactoryGirl.attributes_for(:event, category: 'academic')
                event1.reload
                
                expect(flash[:error]).to eq("You must be logged in to access this section")
                expect(event1.category).to eql(original_event_category)
                response.should redirect_to '/events'
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
            let!(:user1) { FactoryGirl.create(:user) }
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
                Event.create({
                    :title => 'Varsity Football vs. UPenn', 
                    :category => 'athletics', 
                    :organizer => 'Varisty Football', 
                    :user_id => user1.id,
                    :start_time => DateTime.parse('15th November 14:00:00'),
                    :end_time => DateTime.parse('15th November 15:00:00')
                })
                @events = Event.all
            end
        
            it 'should return all events if no categories selected and no sort by' do 
                get :index

                assert_response :success
                response.should render_template('index')

                expect(@categories_to_show_hash).to eq(nil)
                expect(@sort_by).to eq(nil)
                expect(session['categories']).to eq(["athletics", "academics", "career", "culture", "fun"])
                expect(session['sort_by']).to eq('id')
                expect(Event.all.count).to eq(@events.count)
                expect(Event.first).to eq(@events.first)
            end

            
            # TODO: do we really need sort after importing calendar?

            # it 'should assign instance variable for title header' do
            #     get :index, { sort: 'start_time'}
            #     expect(event.title).to eql('CS Coffee Chat')
            # end
        
            # it 'should assign instance variable for release_date header' do
            #   get :index, { sort: 'organizer'}
            #   expect(event.title).to eql('CS Coffee Chat')
            # end
        end
    end
end
