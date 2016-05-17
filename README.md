
Part 1: Requesting a Puzzle

When your app launches, I'd like to see an interface that includes the following elements: a Title for your App, a list of the currently in progress games from previous sessions, and a button for starting a new game, a button for seeing the credits for your game.

When the app launches , it should send a request to the capabilities webservice described for the Java team. the response should contain a dictionary that has the capabilities that the server supports. If the server supports a feature, then we should make that feature something that the user can request. The app should use Core data to store the received puzzles between launches.

When you select the new game button I want to go to a new view controller that uses the following screen shot as a guide.

![](https://tiy-learn-content.s3.amazonaws.com/eb66c8b6-Word%20Search%20-%20settings.png)

Team 1:

https://polar-savannah-54119.herokuapp.com/capabilities

https://polar-savannah-54119.herokuapp.com/puzzle

Team 2:

https://floating-taiga-20677.herokuapp.com/capabilities

https://floating-taiga-20677.herokuapp.com/puzzle

Heroku automatically spins down free-tier apps that aren't being used. As such, the first requests to these services after a while may take a moment to return any results.

The contents of this settings tableView should be determined from the response from the \capabilities service described above. If the Angle feature is missing from the /capabilities response, then the user shouldn't have it as an option.

[
    {
        "name": "Horizontal",
        "description": "Adds words horizontally in the puzzle",
        "keyword": "horizontal" 
    },
    {
        "name": "Vertical",
        "description": "Adds words vertically in the puzzle",
        "keyword": "horizontal" 
    },
    {
        "name": "Angle",
        "description": "Adds words at an angle in the puzzle",
        "keyword": "angle" 
    }
]

When the user hits the Play! button at the bottom, I want the contents of each of the user interface elements to be added to a NSDictionary that looks similar to the Request Body described below.

{
    "width": 20,
    "height": 20,
    "words": 10,
    "minLength": 4,
    "maxLength": 8,
    "capabilities": ["horizontal", "vertical", "angle"]
}

