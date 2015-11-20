# Biphub
Biphub is a web/mobile application that allows teams of teachers and administrators to accurately track the implementation behavoir interventions.

- The mobile application allows for teachers to quickly and accurately enter data directly into the database

- The web application allows for Sped. teachers and service coordinators to view and query the data.

## Contributing:
Biphub is being built by a cadre of generous developers. Develelopement is coordinated through a trello board, https://trello.com/b/KrmMLQ2l/biphub-project-board.

### Current Contributors
Adam Fluke
Jacob Rogers
Harvey Ngo
Chris Scott

## Current Alpa Deployement
The developement app is released to heroku at: https://biphub.herokuapp.com/

## Testing
When adding features to Biphub, it is crucial that we add the necassary test to allow the project to be maintained over the long term. As such, please follow these guidelines when making tests, and before making the pull request ensure all tests are passing.
1. Model test don't need to test ActiveRecord, or associations. They should test all validations and any instance or class methods on models.
2. Controller tests need to be made for each controller action that has a route. To the greatest degree possible, models shoule be stubbed out with FactoryGirl objects.
3. A senario (feature test) should be made for your feature, including testing for failures. All feature tests should be marked as js: true so that they are run by selenium.