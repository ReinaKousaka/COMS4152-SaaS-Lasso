Feature: login as Users

  As an event organizer
  I want to login to create the events

Background: events have been added to database

  Given the following events exist:
  | title                 | category  | location  | user_id | start_time | end_time |
  | Films on Furnald: The Lion King | culture |  Furnald Lawn  | 1 | 30th October 20:00:00 | 30th October 20:00:00 |
  | CS Coffee Chat | fun | Mudd | 1 | 1st November 14:00:00 | 1st November 14:00:00 |
  | Undergraduate Holiday Bash | fun | John Jay Lounge | 1 | 2nd December 18:00:00 | 2nd December 18:00:00 |
  | Networking Roundtable in Finance | career | Lerner Audiotorium | 1 | 15th November 14:00:00 | 15th November 14:00:00 |
  | Varsity Football vs. UPenn | athletics | Baker Stadium | 1 | 13th November 15:00:00 |  13th November 15:00:00 |

  Given the following users exist:
  | email | organizer_name | password_digest |
  | admin@lasso.com | admin | admin |
  | cs@lasso.com | cs department | admin123 | 

  And I am on the Lasso home page
  Then 5 seed events should exist
  Then 2 seed users should exist

  Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    Then the field "email" is empty
    Then the field "organizer_name" is empty
    Then the field "password" should be null

  Scenario: Error on empty fields
    Given I am on the Lasso home page
    When I follow "Register"
    And  I press "Sign up"
    Then the field "email" should be with error
    Then the field "organizer_name" should be with error


  Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    When I fill in "email" with "haha@columbia.edu"
    And I fill in "organizer name" with "hahaha"
    And I fill in "password" with "haha"
    And I press "Sign up"
    And I should see "password" error messages

  Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    When I fill in "email" with "haha@columbia.edu"
    And I fill in "organizer name" with "hahaha"
    And I fill in "password" with "hahahahahha"
    And I press "Sign up"
    Then I should be on the Lasso home page
    And I should see "Hi, hahaha"
    Then 3 seed users should exist
    Then I should be on the Lasso home page
    When I follow "Sign Out"
    Then I should be on the Lasso home page
    And I should see "Hi, you need to sign in!"
    When I follow "Sign In"
    Then I should be on the Sign In page
    When I fill in "email" with "haha@columbia.edu"
    And I fill in "password" with "hahahahahha"
    And I press "Sign In"
    Then I should be on the Lasso home page
    And I should see "Hi, hahaha"



 Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    When I fill in "email" with "yt2781@columbia.edu"
    And I fill in "organizer name" with "yunyun"
    And I fill in "password" with "admin123"
    And I press "Sign up"
    Then I should be on the Lasso home page
    And I should see "Hi, yunyun"
    Then 3 seed users should exist
    When I follow "Add new event"
    Then I should be on the Create New Event page
    When I fill in "Title" with "Christmas Holiday"
    And I select "academics" from "event_category"
    And  I fill in "Location" with "Butler Lower Plaza"
    And  I select datetime "2022 December 24 - 19:00" as the "event_start_time"
    And  I select datetime "2022 December 25 - 22:00" as the "event_end_time"
    And I press "Save Changes"
    And I should see "Christmas Holiday"
    When I go to the edit page for "Christmas Holiday"
    And  I select "fun" from "Category"
    And  I press "Update event Info"
    Then the category of "Christmas Holiday" should be "fun"
    When I go to the details page for "Christmas Holiday"
    When I press "Delete"
    And I should not see the following events: "Christmas Holiday"

  Scenario: Edit an event without access
    When I go to the edit page for "CS Coffee Chat"
    And  I fill in "Title" with "Coffee Chat"
    And  I press "Update event Info"
    Then I should see "You are not the event organizer for this event."
    And I should not see the following events: "Coffee Chat"
  
  Scenario: Search for event
    Given I am on the Lasso home page
    And  I fill in "search_by" with "Coffee"
    And I press "Search"
    Then the number of search results of "Coffee" should be 1









