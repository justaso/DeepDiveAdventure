# DeepDiveAdventure
2D Game written in Java Processing language, where player is in control of a submarine with arrow keys diving deeper in to the ocean,
having to avoid various obstacles and collect 'air' to score points and regain health.

This game has been written in Java Processing language which is built on Java and essentially has the same syntax and similar features.

I have utilised OOP design techniques such as encapsulation (variable and method visibility), inheritance (all obstacles
inherit from Obstacle superclass) and polymorphism (method overriding and overloading).

Another thing worth noting is the leaderboard implementation with a Bubble Sort algorithm, where after the game is finished, user is
prompted to enter his username, his score and username are added to a highscore list, then sorted to keep only Top 5 highscores and
written to a text file for storage.

For demonstration purposes the number of levels was kept at 4 to demonstrate the increasing difficulty where obstacles increase in number and speed with each level. The level time was also kept to a minimum (10s) for demonstration purposes.

The obstacles all move in a different pattern, and Narwhal obstacle moves towards the player.

To run the game, please download Processing for your machine from: "https://processing.org/download/" and 
run the Submarinez.pde file.
