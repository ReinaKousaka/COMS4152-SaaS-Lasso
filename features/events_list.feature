Feature: display list of events filtered by MPAA rating

  As a Columbia student
  So that I can quickly browse events based on my preferences or major
  I want to see events sorted by title or release date

Background: events have been added to database

  Given the following events exist:
  | title                 | category  | organizer | location  | start_time | end_time
  | Films on Furnald: The Lion King  | culture | Film Society      | Furnald Lawn  | 1992-11-25 |
  | CS Coffee Chat | fun | CS department | Mudd | | 
  And I am on the Lasso home page
  Then 2 seed events should exist

Scenario: change name for existing event
  When I go to the edit page for "CS Coffee Chat"
  And  I fill in "Title" with "Coffee Chat"
  And  I press "Update event Info"
  Then I should see "Coffee Chat"

Scenario: change category for existing event
  When I go to the edit page for "Films on Furnald: The Lion King"
  And  I select "fun" from "Category"
  And  I press "Update event Info"
  Then the category of "Films on Furnald: The Lion King" should be "fun"

Scenario: add start time of existing event
  When I go to the edit page for "CS Coffee Chat"
  And  I select datetime "2022 October 2 - 19:00" as the "event_start_time"
  And  I press "Update event Info"
  Then the start time of "CS Coffee Chat" should be "2022 October 2 - 19:00"





