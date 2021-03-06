Feature: Create a run

    Scenario: I can't create an empty run
        Given test project "default"
          And I am on "/"
         When I click on "xpath=//div[@data-project='TEST-default']//a[contains(., 'Create a run')]"
         Then I should see "New run for"
         Then I should see "TEST-default" in field "id=run_project_name"
         When I click on "Create run"
         Then I should see "You must select at least one feature"

    Scenario: Execute a regular run
        Given test project "default"
          And I am on "/"
         When I click on "xpath=//div[@data-project='TEST-default']//a[contains(., 'Create a run')]"
         Then I should see "New run for"
         Then I should see "TEST-default" in field "id=run_project_name"
         When I click on "xpath=//input[@type='checkbox' and @data-path='']"
          And I click on "Create run"
         Then I should see "3 PENDING"
          And I should see "0 RUNNING"
          And I should see "css=h1 .status-pending"
         When I run all units
         Then I should see "css=h1 .status-succeeded"
          And I should see "0 PENDING"
          And I should see "3 SUCCEEDED"

    Scenario: Execute subset of features
        Given test project "default"
          And I am on "/"
         When I click on "xpath=//div[@data-project='TEST-default']//a[contains(., 'Create a run')]"
         Then I should see "New run for"
         Then I should see "TEST-default" in field "id=run_project_name"
         When I click on "css=div.panel[data-path=''] > div.panel-heading > a.expand"
         When I click on "xpath=//input[@type='checkbox' and @data-path='sub']"
          And I click on "Create run"
         Then I should see "2 PENDING"
          And I should see "0 RUNNING"
          And I should see "css=h1 .status-pending"
         When I run all units
         Then I should see "css=h1 .status-succeeded"
          And I should see "0 PENDING"
          And I should see "2 SUCCEEDED"

    Scenario: Execute test with properties
        Given test project "properties"
          And I am on "/"
         When I click on "xpath=//div[@data-project='TEST-properties']//a[contains(., 'Create a run')]"
          And I fill:
            | Result | Success |
          And I click on "xpath=//input[@type='checkbox' and @data-path='']"
          And I click on "Create run"
         Then I should see "1 PENDING"
         When I run all units
         Then I should see "1 SUCCEEDED"

          And I am on "/"
         When I click on "xpath=//div[@data-project='TEST-properties']//a[contains(., 'Create a run')]"
          And I fill:
            | Result | Fail |
          And I click on "xpath=//input[@type='checkbox' and @data-path='']"
          And I click on "Create run"
         Then I should see "1 PENDING"
         When I run all units
         Then I should see "1 FAILED"
