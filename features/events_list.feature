Feature: display list of Events

  As a Columbia student
  So that I can quickly browse events based on my preferences or major
  I want to see events sorted by title or release date

Background: events have been added to database

  Given the following events exist:
  | title                 | category  | location  | user_id | start_time | end_time |
  | Films on Furnald: The Lion King | culture | Furnald Lawn  | 1| 2nd December 20:00:00 | 2nd December 20:00:00 |
  | CS Coffee Chat | fun | Mudd | 1 | 1st December 14:00:00 | 1st December 14:00:00 |
  | Undergraduate Holiday Bash | fun | John Jay Lounge | 1 | 6nd December 18:00:00 | 6nd December 18:00:00 |
  | Networking Roundtable in Finance | career | Lerner Audiotorium | 1 | 15th December 14:00:00 | 15th December 14:00:00 |
  | Varsity Football vs. UPenn | athletics | Baker Stadium | 1 | 13th December 15:00:00 |  13th December 15:00:00 |


  And I am on the Lasso home page
  Then 5 seed events should exist

  Given the following users exist:
  | email | organizer_name | password_digest |
  | admin@lasso.com | Admin | 123 |


  Given I am on the Lasso home page
  When I follow "Register"
  And I fill in "email" with "tatum@lasso.com"
  And I fill in "organizer_name" with "Tatum"
  And I fill in "password" with "admin123123"
  And I press "Sign up"
  Then I should be on the Lasso home page
  And I should see "Hi, Tatum"
  Then 2 seed users should exist

Scenario: Sign Out
  Given I am on the Lasso home page
  When I follow "Sign Out"
  Then I should be on the Lasso home page
  And I should see "Hi, you need to sign in!"
  Then I follow "Sign In"
  And I fill in "email" with "tatum@lasso.com"
  And I fill in "password" with "admin123123"
  And I press "Sign In"
  Then I should be on the Lasso home page
  And I should see "Hi, Tatum"


Scenario: Add an event
  Given I am on the Lasso home page
  Then I follow "Add new event"
  Then I should be on the Create New Event page
  When I fill in "Title" with "Year End Party"
  And I select "fun" from "event_category"
  And  I fill in "Location" with "Butler Lower Plaza"
  And  I select datetime "2022 December 31 - 19:00" as the "event_start_time"
  And  I select datetime "2022 December 31 - 22:00" as the "event_end_time"
  And I press "Save Changes"
  Then I should be on the Lasso home page
  And I should see "Year End Party"
  When I go to the details page for "Year End Party"
  When I press "Delete"
  And I should not see the following events: "Year End Party"

Scenario: Select a catergory
  Given I am on the Lasso home page
  Then I follow "Add new event"
  Then I should be on the Create New Event page
  When I fill in "Title" with "2022 Year End Party"
  And I select "fun" from "event_category"
  Then I should see "fun"

Scenario: restrict to events with "fun" or "culture" category
  When I check the following categories: fun, culture
  And I uncheck the following categories: athletics, academics, career
  And I press "Refresh"
  Then I should see the following events: CS Coffee Chat, Undergraduate Holiday Bash
  Then I should not see the following events: Networking Roundtable in Finance, Varsity Football vs. UPenn 

Scenario: all categories selected
  When I check all the categories 
  And I press "Refresh"
  Then I should see all the categories


