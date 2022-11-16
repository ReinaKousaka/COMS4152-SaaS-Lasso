Feature: kogin as Users

  As an event organizer
  I want to login to create the events

Background: events have been added to database

  Given the following events exist:
  | title                 | category  | organizer | location  | user_id | start_time | end_time |
  | Films on Furnald: The Lion King | culture | Film Society | Furnald Lawn  | 1 | 30th October 20:00:00 | 30th October 20:00:00 |
  | CS Coffee Chat | fun | CS department | Mudd | 1 | 1st November 14:00:00 | 1st November 14:00:00 |
  | Undergraduate Holiday Bash | fun | Undergraduate Student Life | John Jay Lounge | 1 | 2nd December 18:00:00 | 2nd December 18:00:00 |
  | Networking Roundtable in Finance | career | CCE | Lerner Audiotorium | 1 | 15th November 14:00:00 | 15th November 14:00:00 |
  | Varsity Football vs. UPenn | athletics | Varisty Football | Baker Stadium | 1 | 13th November 15:00:00 |  13th November 15:00:00 |

  Given the following users exist:
  | email | username | password |
  | admin.com | admin | 123 |
  | yt2781@columbia.edu | yunyun | admin | 

  And I am on the Lasso home page
  Then 5 seed events should exist
  Then 2 seed users should exist

  Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    Then the field "email" is empty
    Then the field "username" is empty
    Then the field "password" should be null

  Scenario: Error on empty fields
    Given I am on the Lasso home page
    When I follow "Register"
    And  I press "register"
    Then the field "email" should be with error
    Then the field "username" should be with error


  Scenario: Go to register page
    Given I am on the Lasso home page
    When I follow "Register"
    Then I should be on the Register page
    When I fill in "Email" with "haha@columbia.edu"
    And I fill in "Username" with "hahaha"
    And I fill in "Password" with "haha"
    And I press "register"
    Then I should be on the Lasso home page
    And I should see "Hi, hahaha"
    Then 3 seed users should exist

  Scenario: Sign Out
    Given I am on the Lasso home page
    When I follow "Sign out"
    Then I should be on the Lasso home page
    And I should see "You are not signed in!"
    Then 2 seed users should exist

  Scenario: Sign In
    Given I am on the Lasso home page
    When I follow "Sign in"
    Then I should be on the Sign In page
    When I fill in "Email" with "yt2781@columbia.edu"
    And I fill in "Password" with "admin"
    And I press "Sign In"
    Then I should be on the Lasso home page
    And I should see "Hi, yunyun"
    Then 2 seed users should exist
    When I follow "Add new event"
    Then I should be on the Create New Event page
    When I fill in "Title" with "Thanksgiving Holiday"
    And I select "academics" from "event_category"
    And  I fill in "Location" with "Butler Lower Plaza"
    And  I fill in "Organizer" with "Social Club"
    And  I select datetime "2022 November 24 - 19:00" as the "event_start_time"
    And  I select datetime "2022 November 24 - 22:00" as the "event_end_time"
    And I press "Save Changes"
    And I should see "Thanksgiving Holiday"
    When I go to the edit page for "Thanksgiving Holiday"
    And  I select "fun" from "Category"
    And  I press "Update event Info"
    Then the category of "Thanksgiving Holiday" should be "fun"


  Scenario: Edit an event without access
    When I go to the edit page for "CS Coffee Chat"
    And  I fill in "Title" with "Coffee Chat"
    And  I press "Update event Info"
    Then I should see "You must be logged in to access this section"
    And I should not see the following events: "Coffee Chat"

  Scenario: Delete an event without access
    When I go to the details page for "CS Coffee Chat"
    When I follow "Delete"
    Then I should see "You must be logged in to access this section"




