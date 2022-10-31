
Given /the following events exist/ do |event_table|
    event_table.hashes.each do |event|
      Event.create event
    end
end
  

Then /(.*) seed events should exist/ do | n_seeds |
    expect(Event.count).to eq n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    expect(page.body.index(e1) < page.body.index(e2))
end
  
  When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    rating_list.split(', ').each do |rating|
      step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
    end
  end
  
  Then /I should see all the movies/ do
    # Make sure that all the movies in the app are visible in the table
    Movie.all.each do |movie|
      step %{I should see "#{movie.title}"}
    end
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