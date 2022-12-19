
Given /the following events exist/ do |event_table|
    event_table.hashes.each do |event|
      Event.create event
    end
end

  

Then /(.*) seed events should exist/ do | n_seeds |
    expect(Event.count).to eq n_seeds.to_i
end


When /I (un)?check the following categories: (.*)/ do |uncheck, category_list|
    category_list.split(', ').each do |category|
    step %{I #{uncheck.nil? ? '' : 'un'}check "categories_#{category}"}
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


Then /I should see "(.*)" has been deleted/ do |event_name|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).not_to have_content(event_name)
end

 
Then /^the field "(.+)" is empty/ do |field|
  field = find_field(field)
  expect(field.value).to eq("")
end

Then /^the field "(.+)" should be null/ do |field|
  field = find_field(field)
  expect(field.value).to eq(nil)
end

Then /^the field "(.+)" should be with error/ do |field|
  expect(page).to have_content("Account information fields cannot be empty")
end

Then /I should see "(.*)" error messages/ do |field|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).to have_content("Password is too short!")
end


Then /^the number of search results of "(.*)" should be (.*)/ do |keyword, num|
  @search_param = keyword.downcase
  @search_result = Event.all.where("lower(title) LIKE :search", search:"%#{@search_param}%")
  expect(@search_result.size).to eq num.to_i
end

