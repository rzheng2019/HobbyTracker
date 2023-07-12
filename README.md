#  Hobby Tracker

## Description

Hobby Tracker is a native iOS application that is designed to log user hobbies done throughout life. 
Each hobby can be rated with a 5 star system and be provided with descriptions and feedback. 

![](https://github.com/rzheng2019/HobbyTracker/blob/main/HobbyTrackerGIF.gif)

## Getting Started

1. Make sure to have XCode Version 14.3.1 or above installed on your computer.
2. Open the project files in XCode.
3. Build and run project (preferably on iPhone 14 versions).
4. Click "Add New Hobby+" button and browse through hobby list.
5. Once hobby is added, click hobby icons and modify accordingly to personal preference.

## Architecture

- Hobby Tracker was implemented using Model View View-Model (MVVM) archiecture.
- Firebase Firestore was used to store hobby list data.

## Structure

- "Models": Files that cointain the models for what a hobby consists of.
- "ViewModels": Files that contain the view models that provide data and functionality to be used by views.
- "Views": Files that use view models to display user interface with data.


