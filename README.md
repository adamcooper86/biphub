# Biphub
Biphub is a web/mobile application that allows teams of teachers and administrators to accurately track the implementation of behavior interventions.

- The mobile application allows for teachers to quickly and accurately enter data directly into the database. You can see the mobile app repo at https://github.com/adamfluke/BipHubMobile.

- The web application allows for Special Educaiton Teachers and service coordinators to view and query the data.

## Contributing:
Biphub is being built by a cadre of generous developers. Develelopement is coordinated through a trello board, https://trello.com/b/KrmMLQ2l/biphub-project-board.

### Current Contributors
<li>Adam Fluke</li>
<li>Charlotte Manetta</li>
<li>Anderw Patterson</li>

## Current Alpa Deployement
The developement app is released to heroku at: https://biphub.herokuapp.com/

## Testing
When adding features to Biphub, it is crucial that we add the necassary test to allow the project to be maintained over the long term. As such, please follow these guidelines when making tests, and before making the pull request ensure all tests are passing.
<ol>
  <li>Model test don't need to test ActiveRecord, or associations. They should test all validations and any instance or class methods on models.</li>
  <li>Controller tests need to be made for each controller action that has a route. To the greatest degree possible, models shoule be stubbed out with FactoryGirl objects.</li>
  <li>A senario (feature test) should be made for your feature, including testing for failures. All feature tests should be marked as js: true so that they are run by selenium.</li>
</ol>

## Information:
Types of goals:
- qualitative: scale of 1-5
- incident: an integer of the # of incedences
- time(length): an integer representing the number of seconds/minutes
- percent: an integer 0-100 representing a percentage