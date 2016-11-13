# FunRun

**FunRun** is an application makes running more fun and training more continuable.
Many people run these days, for their health, for diet,  to train for full marathon. They spend a lot of hours for running. Most of them run with smartphone to use a running application or GPS watch to track the running activiy. Running app is key tool for many runners. However existing running app is not perfect enough.
1. Runners love to check their running activities and some stastical data from their activies, but existing applicatiosn/services charge a lot for analytics data. One of existing applicaiton charges $10/month. We believe this feature should be default feature. 
2. Many runners does not have personal running coach or running specialist in their friends, they need variety of advises, such as advise for shoose or running pace, etc.
3. Most of existing running applciations my or friend's activitis UI is simple table view. It is not funncy enough to check friend's activities like Facebook app. The app provide FUNNCY UI.
4. Existing apps just draws red line on the map for course. The app provide more information like course colored by running pace per mile.
5. May of us are interested in what other runners are listing during run, and they need recommendation. The app could provide music recommenation for running.
Our new running application will solve aboves. We will build next genation running application!!

## User Stories

### The following functionality are **required** to be implemented:

- [ ] Statistics Page **(tap item, default page)**
    - [ ] Life statistics (accumulated data: total distance, total running hours, total climbs, etc.)
    - [ ] Have a Github-style heat-map image, color changes based on distance.
    - [ ] A scroll view showing some histograms about distances, durations.
        - [ ] Switch among group levels: week, month, year.
    - [ ] A scroll view showing the best record of distance, duration, calories, activities (PR).
        - [ ] Switch between overall activities and only race activities.

- [ ] Running Page **(tap item)**
    - [ ] Start page:
        - [ ] A user's location pin icon on a map view
        - [ ] Buttons to start running and cancel
        - [ ] Options to be a race or just free exercise
    - [ ] Running page:
        - [ ] Dash board showing distance, speed, time.
        - [ ] A button to finish this running
    - [ ] Review page:
        - [ ] The running route on map reflects speed change by using different colors for different speed levels.
        - [ ] Attach comments
        - [ ] Buttons to save, delete

- [ ] List of activity page **(tap item)**
    - [ ] Filter by distance, place, duration, label
    - [ ] Each running activity should include: map of route, distance, duration

- [ ] Click on a cell from List of activity page, show up a detailed page of that activity:
    - [ ] Some histograms of speed/elevation/pace according to time intervals/mile
    - [ ] Weather at that time
    - [ ] The running route on map reflects speed change by using different colors for different speed levels.
    - [ ] Show the comment of that activity, can edit the comment
    - [ ] labeling, deleting that activity

- [ ] Goal/Schedule Page **(tap item)**
    - [ ] Button to create a new goal (target distance for a specific period, run a race by a specific day)
    - [ ] A paging view showing all of your goals
    - [ ] Remind the user if he hasn't run for a long time (push notification of a sentence).

### The following are **optional** features that may not be implemented if time is limited:

- [ ] Goal/Schedule Page
    - [ ] Set up running plan in calendar and link to Google Calendar

- [ ] Home Page
    - [ ] A home time line that list your friends' posts and live statuses if someone is currently running.
    - [ ] A home time line that list the current user's activity history.
    - [ ] Switch between friends' posts list and my own post list.
    - [ ] Select on a post to see its details (photo, GIF).
    - [ ] Make comments, like, repost a friend's post.

- [ ] Running Page
        - [ ] Take photos/video clips, save to library in the middle of running.
        - [ ] select photos/videos on review page

- [ ] Activity (Details) Page
    - [ ] Display the content of an activity (sentences, images, map, GIF)
    - [ ] Display the weather information of that place
    - [ ] Display a list of comments
    - [ ] Links of like, compose comments, repost

- [ ] Statistics Page
    - [ ] Illustrate statistical data of speed, distance and rest time in professional histograms.
    - [ ] Share a running result (distance, route, time, photos) to other social apps (Twitter, Facebook, etc.)
    - [ ] Rank the user's running performance among his friends.

- [ ] Me Page
    - [ ] Make monthly schedule and link to Google Calender.


### The following are **bonus** features:

- [ ] Home Page 
    - [ ] Buttons to filter out only posts, only live statuses, or only recommendations.
    - [ ] Import friends from user's other social platform account (e.g. Facebook) and automatically send invitation emails to them.
    - [ ] Include a preview of the media (photo, GIF, video) in the home time line.
    - [ ] Interact with a friend's photo post by scrawling on it and automatically repost with that scrawling.
    - [ ] Emoji support
    - [ ] Recommend popular running trials, running shoes, music to runners (naturally included in hoem time line).
    - [ ] Track what the runner is listenning to when he is running, reflect that on his live status.
    
- [ ] Cruise Page
    - [ ] The map also has image tags at different locations, meaning that some users shared photos at those locations.
    - [ ] Clicking the image tag brings to a collection of those photos.

- [ ] Running Page
    - [ ] Voice advice (e.g. reminder to rest)
    - [ ] Live video broadcast streaming during running.
    
- [ ] Profile Page
    - [ ] A map with green flashing dots representing other current runnining users, and blue flashing dot representing your location.
    - [ ] Clicking the green dots pops up a box showing that user's profile.
    - [ ] Clicking on the pop-up box brings to that user's profile page.
    - [ ] A subscript number of each image tag represents how many photos have been taken at that location (larger number means more popular).
    - [ ] Clicking on a tile on the Github-style wall will display the information of runnin activity on that day.

- [ ] Me Page
    - [ ] Import iHealth data.
    - [ ] Provide simple training courses for new runners.

    
## App Wire-framing

Here's a diagram showing the wire frame of the app:

<img src='https://github.com/SprintCoders/FunRun/blob/master/public_images/wire_frame/wire-frames.png' title='wire-framing' width='' alt='wire-graming' />


## Video Walkthrough

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes


## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


