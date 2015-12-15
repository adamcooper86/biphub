# Biphub
Biphub is a web/mobile application that allows teams of teachers and administrators to accurately track the implementation of behavior interventions.

- The mobile application allows for teachers to quickly and accurately enter data directly into the database. You can see the mobile app repo at https://github.com/adamfluke/BipHubMobile.

- The web application allows for Special Educaiton Teachers and service coordinators to view and query the data.

## Contributing:
Biphub is being built by a cadre of generous developers. Develelopement is coordinated through a trello board, https://trello.com/b/KrmMLQ2l/biphub-project-board.

### Current Contributors
<ul>
  <li>Adam Fluke</li>
  <li>Charlotte Manetta</li>
  <li>Anderw Patterson</li>
</ul>

## Current Alpa Deployement
The developement app is released to heroku at: https://biphub.herokuapp.com/

## Testing
When adding features to Biphub, it is crucial that we add the necassary test to allow the project to be maintained over the long term. As such, please follow these guidelines when making tests, and before making the pull request ensure all tests are passing.
<ol>
  <li>Model test don't need to test ActiveRecord, or associations. They should test all validations and any instance or class methods on models.</li>
  <li>Controller tests need to be made for each controller action that has a route. To the greatest degree possible, models shoule be stubbed out with FactoryGirl objects.</li>
  <li>A senario (feature test) should be made for your feature, including testing for failures. All feature tests should be marked as js: true so that they are run by selenium.</li>
</ol>

## Terms:
### Types of goals:
It is important that BipHub corrently manange divergent types of data. To help this, goals are given a meme type, which helps define how the data is tracked, and how the UI is styled. The types of goals are:
<ul>
  <li>Qualitative: scale of 1-5. This is styled as a slider in the mobile app, and a select box in the wwebsite.</li>
  <li>Incident: an integer of the # of incedences. This is styled as an input box in both environments.</li>
  <li>Time(duration): an integer representing the number of seconds/minutes. Styled as select boxes for website, and datebox flipbox for the mobile app.</li>
  <li>Percent: an integer 0-100 representing a percentage. This is styled as a slider on the mobile app and a select box on the website.</li>
</ul>
### Types of Users
Users, in a general sense, are the adults using the application. There are four distinct types of users, but in many cases they are interchangeable.
<ul>
  <li>Admin: This is a limited number of logins that manages the school accounts. They are the site administrators, not school or district employees.</li>
  <li>Coordinator: These users are humans who work at the school, but aren't teachers or speducators. They have the most rights for managing students, speducators, and teachers.</li>
  <li>Speducator: These users are special education teachers employeed at the school. They are special because they have case_students, students whose Bip, Goals, and Cards they directly manage.</li>
  <li>Teacher: The teacher is the general education, classroom teacher. Their primary role is to input data into the system, and do not have students assigned to them to manage bips, or goals, etc.</li>
</ul>
All users owned by a school, coordinators, speducators, or teachers, can be assigned to a observation or card to input data, and can log into the mobile site.