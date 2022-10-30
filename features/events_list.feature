Feature: display list of events filtered by MPAA rating

  As a Columbia student
  So that I can quickly browse events based on my preferences or major
  I want to see events sorted by title or release date

Background: events have been added to database

  Given the following events exist:
  | Event                 | Category  | Organizer | Location  | Start Time | End Time
  | Films on Furnald: The Lion King  | culture | Film Society      | Furnald Lawn  | 1992-11-25 |
  | CS Coffee Chat | fun | CS department | Mudd | | 
  And I am on the Lasso home page
  Then 2 seed events should exist

Scenario: add start time to existing event
  When I go to the edit page for "Coffee Chat"
  And  I fill in "Start Time" with "2022-10-30"
  And  I press "Update Event Info"
  Then the start time of "Coffee Chat" should be "2022-10-30"

Scenario: add a new event to home page
  When I am on the Lasso home page
  And  I press "Add New Event"
  And  I fill in "Event Title" with "Halloween Party"
  And  I fill in "Category" with "fun"
  And  I fill in "Organizer" with "social club"
  And  I fill in "Start Time" with "2022-10-30"
  And  I fill in "End Time" with "2022-10-31"
  And  I should see "Halloween Party"


