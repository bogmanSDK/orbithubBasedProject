# Ticket: AIH-60

## Summary
Create a page with tabs

## Description
Create a page with two Tabs “Main“ and “Settings““Main“ and “Settings“ should be a placeholdersChoos the light theme
---
## Acceptance Criteria
### Scenario 1: User navigates to the new page with tabs
Given the user is logged into the application under Option A
When the user navigates to the new page in the application's navigation structure
Then the user should see a new page with two tabs labeled as “Main” and “Settings”
And the “Main” and “Settings” tabs should be placeholders
### Scenario 2: Page responsiveness on various device screen sizes
Given the user is on the new page with tabs
When the user views the page on various device screen sizes
Then the page should be responsive and support these different screen sizes
### Scenario 3: Switchable theme between light and dark modes
Given the user is on the new page with tabs
When the user switches the theme from light to dark mode
Then the page should reflect the selected theme accordingly
And the theme should be saved in the user's settings
### Scenario 4: Content displayed in the "Main" and "Settings" tabs
Given the user is on the new page with tabs
When the user clicks on the “Main” and “Settings” tabs
Then the appropriate content for each tab as per Option A should be displayed
### Scenario 5: Error scenario when the theme fails to switch
Given the user is on the new page with tabs
When the user attempts to switch the theme from light to dark mode
And the theme fails to switch
Then an error message should be displayed
And the theme should remain as it was prior to the switching attempt.

## Acceptance Criteria
### Scenario 1: User navigates to the new page with tabs
Given the user is logged into the application under Option A
When the user navigates to the new page in the application's navigation structure
Then the user should see a new page with two tabs labeled as “Main” and “Settings”
And the “Main” and “Settings” tabs should be placeholders

## Implementation Instructions

- Implement code changes following existing patterns
- Create unit tests with good coverage
- Write development summary to outputs/response.md
- DO NOT create branches or push - handled by workflow

