# README

This is a an app to enter and calculate score of a several games of bowling.
The final score for the game will be shown after all the 10 frames are entered for each game.

### Ruby version - ruby 3.2.0

### Database creation
  * rails db:create
  * rails db:migrate db:test:prepare


### Running the app
  * On console > rails s
  * On browser > http://localhost:3000/games/new
![Screen of Game start](app/assets/images/start.png?raw=true "Starting a Game")

Frame 10
![Screen of Last Frame](app/assets/images/screen10.png?raw=true "Last Frame")

Display the Score
![Screen of Last Frame](app/assets/images/end.png?raw=true "Display Score")
### How to run the test suite
  * rspec /Users/mk/apr/bowling/test/models/roll_spec.rb
  
  * rspec /Users/mk/apr/bowling/test/models/game_spec.rb

### To do
  * Add client side validations
  * Add more specs



