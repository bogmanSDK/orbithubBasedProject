# Ticket: AIH-56

## Summary
Add page with tabs

## Description
Add page with two tabs “Home“ and “Settings“Use default approachIt’s just a placeholder
---
## Acceptance Criteria
### Scenario 1: User navigates to the new page
Given a user is logged into the application
When the user navigates to the new page
Then two tabs labelled "Home" and "Settings" should be visible
And the "Home" tab should be selected by default
### Scenario 2: User interacts with the "Home" tab
Given a user is on the new page and the "Home" tab is selected
When the user clicks on the "Home" tab
Then the application should display the content associated with the "Home" tab
And no changes should be made to the "Settings" tab
### Scenario 3: User interacts with the "Settings" tab
Given a user is on the new page and the "Home" tab is selected
When the user clicks on the "Settings" tab
Then the application should display the content associated with the "Settings" tab
And no changes should be made to the "Home" tab
### Scenario 4: User navigates away and returns to the new page
Given a user is on the new page and has selected the "Settings" tab
When the user navigates to a different page and then returns to the new page
Then the "Home" tab should be selected by default
And the content associated with the "Home" tab should be displayed
### Scenario 5: User attempts to navigate to new page without valid login
Given a user is not logged into the application
When the user attempts to navigate to the new page
Then an error message should be displayed
And the user should be redirected to the login page

## Acceptance Criteria
### Scenario 1: User navigates to the new page
Given a user is logged into the application
When the user navigates to the new page
Then two tabs labelled "Home" and "Settings" should be visible
And the "Home" tab should be selected by default

## Implementation Instructions

- Implement code changes following existing patterns
- Create unit tests with good coverage
- Write development summary to outputs/response.md
- DO NOT create branches or push - handled by workflow

