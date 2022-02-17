
# API-Gateway/ Lambda-Function Structure

## General Information

I was working on a Wordle App for the past few days, The New York Times bought Wordle recently, so it's being flagged as containing metadata for third party content.  

This is the rejection message I received. 
> Your metadata appears to contain third party content. Specifically, your app is leveraging Wordle.

That is fair enough, so I won't try to reupload this. Instead I decided to just create this Repo. I already have a private repository for this project but it contains some API keys and other AWS stuff which I don't want to expose. 

## Screenshots

<p align = "middle">
  <img src="/Images/image1.png" width="200" height="400">
  <img src="/Images/image3.png" width="200" height="400">
  <img src="/Images/image2.png" width="200" height="400">
  <img src="/Images/image4.png" width="200" height="400">
</p>


## Tech Stack

### Client Side

1. Swift
2. UIKit
3. SwiftUI

### Server Side

1. Python
2. AWS-Lambda
3. API-Gateway
4. DynamoDB
5. CloudWatch

### Third Party Libraries 

1. Google Admob SDK
2. Lottie iOS

## Code

I have used both SwiftUI and UIKit in this project, A few months ago I asked [Christian Selig](https://twitter.com/ChristianSelig) wheather I should use UIKit (I only knew SwiftUI back then), he said yes(along with a really good explanation). So I do know UIKit along with autolayout but I am much more comfortable making UI's with the newer framework(SwiftUI). 

So code is a little odd and hard to understand, every view is a UIKit ViewController, but embedded in that ViewController is a UIHostingController. UIHostingController is part of the SwiftUI framework and it allows us to embed SwiftUI views into UIKit controllers. 

So for example lets consider the main-menu. It's called the WordleViewController. So using viewDidLoad() method, we initilize a UIHostingController which contains a SwiftUI view called WordleMainMenu.swift.

``` let wordleMainMenu = UIHostingController(rootView: WordleMainMenu())```

We than give this wordleMainMenu, the entire screen to work with. 

```
        addChild(wordleMainMenu)
        wordleMainMenu.view.frame = view.frame
        wordleMainMenu.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordleMainMenu.view)

        NSLayoutConstraint.activate([
          wordleMainMenu.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          wordleMainMenu.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          wordleMainMenu.view.topAnchor.constraint(equalTo: view.topAnchor),
          wordleMainMenu.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
```

In UIKit we use a delegation pattern to send data back and forth, but in SwiftUI we have to use the Combine framework, so it's a little odd managing these 2 together. What I did in this project is far from ideal I think, because it was exteremly confusing. I used delegation for everything. This was okay when there was only 1 SwiftUI view nested in a ViewContoller but as soon as there were more views than it was complete chaos, there were 10 diffrenet delegates, each sounding similar and I would consistanly call the wrong delegate without realising it and something random would happen leaving me confused.

Later I learned about NSNotificaitonCenter, which would have been far more appropirate in most of the cases. Since I had no idea this existed, I made some stupid desgin decisions lol. 

For example the main Wordle game is SwiftUI view, its hosted in UIHostingController inside a GameViewController class. 

I have made the GameViewController conform to the GameViewControllerDelegate protocol. 

```
protocol GameViewControllerDelegate {
    func showPauseMenu()
    func showGameAlert(alert: AlertModelData)
    func showGameOverMenu(didWin: Bool)
}
```
But my Wordle SwiftUI view has a ViewModel that contains all the logic, and it manages the game status, like which row is currently being played or is the input valid etc. So when the game is over, the ViewModel knows it and wants to call the delegate and fire showGameOverMenu(didWin: Bool). But I realized that I cant call the delegate from the ViewModel. So instead I came up with a dumb solution lol, everytime user hits the enter button the view model returns a enum, the only purpose of this enum is to check if the SwiftUI view should call the delegate lol. 

```
enum GameStatusForManagingDelegate {
    case alert
    case gameoverLoss
    case gameoverWin
    case ignore
}
```

This was a horrible solution, instead it would have been soo much clearner and similar to have a observer in the GameViewController which listens for a notification, which tells it if the game is over.

This is roughly what the code should have looked like. 


**In NotificationExtensions.swift**
```
extension Notification.Name {
    static let gameOverUserWin = Notification.Name("gameOverUserWin")
    static let gameOverUserLoss = Notification.Name("gameOverUserLoss")
}
```

**In GameViewController.swift**
```

func handleGameOverUserWin() {
  // Handle Game Over Case
  // You can call delegate here
}

func handleGameOverUserLoss() {
  // Handle Game Over Case
  // You can call delegate here
}

override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(handleGameOverUserWin), name: .gameOverUserWin, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleGameOverUserLoss), name: .gameOverUserLoss, object: nil)

    // All Other Things
}
```

**In WordleGameViewModel.swift**

```
func checkGameOverCaseInViewModel() {

  // Perform your checks

  if win {
    NotificationCenter.default.post(name: .handleGameOverUserWin, object: nil)
  }

  else if loss {
    NotificationCenter.default.post(name: .handleGameOverUserLoss, object: nil)
  }

}
```



To make my life a little easier I documented my API's and wrote down their parameters and the what they respond with. I might add more info about my backend later on, but for now this is the stuff I made during devlopment.


## URLS 

1. Juliet_AuthenticateUser ->  https://myAPIGatewayAWSURL
2. Juliet_WordManager -> https://myAPIGatewayAWSURL
3. Juliet_IAPManager -> https://myAPIGatewayAWSURL
4. Juliet_UserSessionManager -> https://myAPIGatewayAWSURL

## API Structure 

### **Juliet_AuthenticateUsers RequestTypes**

1) *initialRegistration*
    - Parameters
      - vendorID (The iOS unique identifier for every device) 
      - requestType (initialRegistration)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode
          }
       }
      ```


### **Juliet_WordManager RequestTypes**

1) *fetchNewSecretWord*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (fetchNewSecretWord)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "secretWord": Array<String>
          }
       }
      ```

2) *updateUserPlayedWordsList*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (updateUserPlayedWordsList)
        - playedWord (When gameover screen is triggered this word was played)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode
          }
       }
      ```


### Juliet_IAPManager RequestTypes

1) *updateUserEnergy*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (updateUserEnergy)
        - userEnergy (userEnergy on the client side)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userEnergy": Int 
          }
       }
      ```

2) *singleGameEnergyUpdate*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (singleGameEnergyUpdate)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userEnergy": Int 
          }
       }
      ```

3) *handleEnergyPurchase*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (handleEnergyPurchase)
        - energyPurchaseAmount - Values i.e. either 5 or 30. Anything else results in a 404 response.
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userEnergy": Int 
          }
       }
      ```


### **Juliet_UserSessionManager RequestTypes**

1) *fetchUserWins*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (fetchUserWins)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userWins": Int
          }
       }
      ```

2) *updateUserWins*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (updateUserWins)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userWins": Int
          }
       }
      ```

3) *statNewGameSession*
      - Parameters
        - userID (Unique identifier for the user, userId = vendorID if the user has not created a account) 
        - requestType (statNewGameSession)
    - Response 
      ``` 
       {
          "lambdaInvocationHttpsStatusCode": HTTPStatusCode, 
          "body": {
              "dynamoDBInvocationHttpsStatusCode": HTTPStatusCode,
              "userEnergy": Int,
              "secretWord": Array<String>
          }
       }
      ```
