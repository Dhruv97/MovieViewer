# MovieViewer

# Project 1 - MovieViewer

MovieViewer is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Cocoapods used:

AFNetworking: https://github.com/AFNetworking/AFNetworking
EZLoadingActivity: https://github.com/goktugyil/EZLoadingActivity

Time spent: 4 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] Customize the UI.

The following **additional** features are implemented:

- [x] User can touch the movie in the tableview to segue to a detailed view.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='movieviewer2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I had trouble figuring out where to implement the loading activity in my viewDidLoad().

## License

    Copyright [2016] [Dhruv Upadhyay]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
