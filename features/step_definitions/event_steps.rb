
Given /the following events exist/ do |event_table|
    event_table.hashes.each do |event|
      Event.create event
    end
end

<<<<<<< Updated upstream
=======
Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create user
  end
end
  
>>>>>>> Stashed changes

Then /(.*) seed events should exist/ do | n_seeds |
    expect(Event.count).to eq n_seeds.to_i
end

<<<<<<< Updated upstream
=======
Then /(.*) seed users should exist/ do | n_seeds |
  expect(User.count).to eq n_seeds.to_i
end
>>>>>>> Stashed changes

Then /^(?:|I )should be on the edit page for "(.+)"$/ do |event_name|
  event_id = Event.find_by(title: event_name).id
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(edit_event_path(event_id))
  else
    assert_equal path_to(edit_event_path(event_id)), current_path
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    expect(page.body.index(e1) < page.body.index(e2))
end
  
When /I (un)?check the following categories: (.*)/ do |uncheck, category_list|
    category_list.split(', ').each do |category|
    step %{I #{uncheck.nil? ? '' : 'un'}check "categories_#{category}"}
    end
end
  
Then /I should see all the events/ do
    # Make sure that all the movies in the app are visible in the table
  Event.all.each do |events|
    step %{I should see "#{event.title}"}
  end
end

Then /^I should (not )?see the following events: (.*)$/ do |no, event_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/
  event_list.split(",").map{|e| "#{e.strip}"}.each do |event|
    # Movie.where(rating: rating).each do |movie|
    if no
      expect(page).not_to have_content(event)
    else
      expect(page).to have_content(event)
    end
    # end
  end
  # pending "Fill in this step in movie_steps.rb"
end

When /I check all the categories/ do 
  Event.all_categories.map{|e| "categories_#{e.strip}"}.each do |category|
    check(category)
  end
end

Then /I should see all the categories/ do
  # Make sure that all the movies in the app are visible in the table
  Event.all.each do |event|
    page.should have_content(event.title)
  end
  # pending "Fill in this step in movie_steps.rb"
end
  
Then /^the category of "(.+)" should be "(.+)"/ do |event_name, category|
    event = Event.find_by(title: event_name)
    visit event_path(event)
    expect(event.category).to eq category
end

When /^(?:|I )select datetime "([^ ]*) ([^ ]*) ([^ ]*) - ([^:]*):([^"]*)" as the "([^"]*)"$/ do |year, month, day, hour, minute, field|
  select(year,   :from => "#{field}_1i")
  select(month,  :from => "#{field}_2i")
  select(day,    :from => "#{field}_3i")
  select(hour,   :from => "#{field}_4i")
  select(minute, :from => "#{field}_5i")
end

Then /^the start time of "(.+)" should be "(.+)"/ do |event_name, start_time|
  event = Event.find_by(title: event_name)
  visit event_path(event)
  expect(event.start_time).to eq start_time
end


Then /I should see "(.*)" has been deleted/ do |event_name|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).not_to have_content(event_name)
end

<<<<<<< Updated upstream
<<<<<<< Updated upstream
Given /^I log in as (.*)$/ do |name|
  step "I log"
end
 
=======

>>>>>>> Stashed changes
=======

>>>>>>> Stashed changes
Then /^the field "(.+)" is empty/ do |field|
  field = find_field(field)
  expect(field.value).to eq("")
end

Then /^the field "(.+)" should be null/ do |field|
  field = find_field(field)
  expect(field.value).to eq(nil)
end

Then /^the field "(.+)" should be with error/ do |field|
  expect(page).to have_content("#{field.capitalize} can't be blank")
end