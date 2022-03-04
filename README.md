# Freight Frenzy scoring iOS app
This is the iOS app I developed for FIRST TECH challenge.The app was developed with Swift. App can run on many devices, thanks to Auto Layout. There are several features for users that I developed:
- Register a team with some info (Can upload team's picture from camera roll), then the app saves the info locally using Core Data.
- Choose a team to play a game round, and the app calculates the score for the team, then you can save and share your score if you want to (The app will ask for you to allow location sharing).
- See all team(s) that registered locally, which were saved before using Core Data.
- Check high score(s) and search for team(s) in top 100 team in the world. It was done using SwiftyJSON to retrieve data from the
API provided, and the list of high scores is displayed using Table View. You can also search for a team using their ID.
- Submit current team score to high score table

You can see the app's demo [here](https://youtu.be/2YIDgfyraLM)

App's navigation pattern:

![Navigation 1](https://github.com/HenryNg101/Freight-Frenzy-scoring-iOS-app/blob/master/Nav1.png)

![Navigation 2](https://github.com/HenryNg101/Freight-Frenzy-scoring-iOS-app/blob/master/Nav2.png)

![Navigation 3](https://github.com/HenryNg101/Freight-Frenzy-scoring-iOS-app/blob/master/Nav3.png)
