# Project 1 - Flixter

Flixter is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 20 hours spent in total

## User Stories

The following **required** functionality is complete:

- User sees an app icon on the home screen and a styled launch screen.
- User can view a list of movies currently playing in theaters from The Movie Database.
- Poster images are loaded using the UIImageView category in the AFNetworking library.
- User sees a loading state while waiting for the movies API.
- User can pull to refresh the movie list.
- User sees an error message when there's a networking error.
- User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

The following **optional** features are implemented:

- User can tap a poster in the collection view to see a detail screen of that movie.
- User can search for a movie by any word in title.
- User can tap on the play button on the detail screen to play the movie trailer on Youtube.
- Customize the UI:
    - Black screens, which involved changing many settings of other components to match tints / make components visible e.g. SearchBar placeholder
    - Detail page includes a darkened/zoomed in version of the poster, overlayed with movie title.
    - Play button on detail screen to launch TrailerViewController
    - Big Title on Now Playing page

The following **additional** features are implemented:

- One-time landing screen following the launch screen that directly connects to TabBarController with a button

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Understanding the components of networking conceptually.
2. Embedding the current screens in a navigation controller.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://imgur.com/a/kFqYFsW

GIF created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

XCode (when downloaded through the App Store) did not finish after waiting for 12 hours and got stuck on the installation screen. This was eventually resolved by installing through Apple Developer. 
Twice, I got a file corrupting bug that made it impossible to continue with the project. The first time, I completely restarted Flixter. The second time, I caught that it was because I was attempting to use components in the private .m files instead of adding them to and importing .h files.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2022] [Shreeya indap]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
