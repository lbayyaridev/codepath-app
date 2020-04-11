Group Project - README Template
===

# Chally

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
In one sentance, Chally is a social media app that focuses on creating and particiapting in chanlanges. This is ment to be a pacle where internet chalanges, such as the ALS Ice Bucket Chalange or Mannequin challange can be posted, shared and disscued. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social Networking / Photo & Video
- **Mobile:** This app would be primarily developed for mobile but would perhaps be just as viable on a computer.
- **Story:** A platform for users to see current trending challenges and more importantly being able to challenge friends, family and the world.
- **Market:** Any person who enjoy viewing current trends and participitating in fun challenges.
- **Habit:** This app could be used as often or as little as possible depending on how free the individual is.
- **Scope:** First we will make it clear how easy it is to set up challenges with friends. The it could evolve into a platform defning new challenges around the world. Being able to become a platform that intrests other brands for advertising.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
Editable profile pages.
Be able to login to acces your own posts.
Be able to make posts (chanalges) including pictures and videos.
Be able to view other peoples posts (chalanges).
Be able to respond to other peoples posts (chalanges).
Search for posts (chanalges).

**Optional Nice-to-have Stories**

Private Chats.
Dark mode.
App notifications.

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
   * Upon downloading or reinstalling the app, the user is prompted to register.
* Home Screen - Challenges at a glance ( Potential Second Feature)
  * User gets to view the current challenges happening with their followers.
* Browse Screen - Trends in the world (Potential Second Feature)
  * Users gets to view challenges happening around the world and check out new users to follow
* Groups Screen - View with groups (First Feature)
  * Users get to see if their groups are active and which ones currently have challenges going on
* Messaging Screen - Chat with friend or group (First Feature)
  * Users get to interact and talk about the challenges.
  * Users can initiate challenges here.
* Profile Screen
  * Allows user to upload a photo and fill in information that is interesting to them and others.
* Setting Screen
  * Allow users to customize the view of the app such as appearance and language
* Challenge Screen (Fist Feature)
  * Allow users to edit their photo / video through tools and customize length of challenge and challenge type.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* [list first screen here]
   * [list screen navigation here]
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.ibb.co/JvJnqXz/IMG-1968.jpg" width=600>
<img src="https://i.ibb.co/WHWZZpX/IMG-1969.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.ibb.co/1q0dLPz/Home.jpg" width=200> <img src="https://i.ibb.co/FghdX6Y/Challenge.jpg" width=200>
<img src="https://i.ibb.co/B65sDJk/Group.jpg" width=200> <img src="https://i.ibb.co/YZ5HwnN/MSG.jpg" width=200>
<img src="https://i.ibb.co/R7qsFP6/No-Challenge.jpg" width=200> <img src="https://i.ibb.co/djqLN5N/Send.jpg" width=200>

### [BONUS] Interactive Prototype
https://marvelapp.com/4h6j389

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]



### Networking
- [Add list of network requests by screen ]
*Home Screen
(Read/GET) Query all posts where user is author
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```

(Create/POST) Create a new like on a post
```

```

(Delete) Delete existing like
```
PFObject.deleteAll(inBackground: Like) { (succeeded, error) in
    if (succeeded) {
        // The array of objects was successfully deleted.
    } else {
        // There was an error. Check the errors localizedDescription.
    }
}
```

(Create/POST) Create a new responce on a post
```
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!

        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }
```

(Delete) Delete existing responce
```
PFObject.deleteAll(inBackground: Responce) { (succeeded, error) in
    if (succeeded) {
        // The array of objects was successfully deleted.
    } else {
        // There was an error. Check the errors localizedDescription.
    }
}
```

*Post Screen
(Create/POST) Create a new post object
```
let Post = PFObject(className:"Post")
Post["creator"] = Username
Post["postText"] = Text
Post["image"] = false
Post["video"] = false
Post["like"] = numofLikes
Post.saveInBackground { (succeeded, error)  in
    if (succeeded) {
        // The object has been saved.
    } else {
        // There was a problem, check error.description
    }
}
```

*Profile Screen 
(Read/GET) Query logged in user object
```
let query = PFQuery(className:"Profile")
query.whereKey("author", equalTo: currentUser)
query.findObjectsInBackground { (users: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let users = users {
      print("Successfully retrieved \(Profile.Name) .")
  // TODO: Do something with Profile...
   }
}
```

(Update/PUT) Update user profile image
```
let query = PFQuery(className:"Profile")
query.getObjectInBackground(withId: "xWMyZEGZ") { (Profile: PFObject?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    } else if let Profile = Profile {
        Profile["Name"] = author
        Profile["image"] = image
        Profile["Description"] = description
        Profile.saveInBackground()
    }
}
```

- [OPTIONAL: List endpoints if using existing API such as Yelp]




