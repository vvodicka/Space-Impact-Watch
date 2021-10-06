# Intimate details of my slightly controversial project

<img height="512" src="https://github.com/vvodicka/Space-Impact-Watch/blob/main/initialimage.png?raw=true" width="427"/>

# Intro

I decided to create almost an exact copy of old Space Impact game from popular Nokia phones from 2000's from scratch. I managed to complete it and the game is currently on [Appstore](https://apps.apple.com/us/app/space-impact-watch/id1550604563#?platform=iphone). This is an article, how the project went. You can figure out pretty exactly what to expect if you work on a similar project.

# Numbers and dates

* project start - 25th Nov 2020
* first production release - 1st June 2021
* work amount - 34 days, hours not tracked, but probably < 100 hours
* lines of code (excluding config  and generated files, basically just .swift files) - 5058
* commits - 73
* sprites created - 43 total, 19 animated with 2 frame animation, custom font for numbers 0-9
* price - Alternate tier A EUR 0.49
  * approximately $0.49 - $0.99

# Download and sale statistics

* total impressions - 339K
* total units downloaded - 1.3K
* total sessions played - 1K
  * this is interesting. ~300 people bought a game, but never started it
* total crashes - 0 🎉
* total proceeds (earnings that went to my account, already stripped from apples fee) - **$475**
  * sales was $738, therefore $263 (35,64%) went to Apple
* top 5 countries

<img src="https://github.com/vvodicka/Space-Impact-Watch/blob/main/sales.png?raw=true"/>

* app units by device
    * iPhone - 1303
    * iPad - 21 (HOW and WHY?)
* app download chart

<img src="https://github.com/vvodicka/Space-Impact-Watch/blob/main/downloadschart.png?raw=true"/>

* sources of download
  * app store search - 453
  * web referrer (mostly reddit and youtube) - 366
  * app store browse - 312
  * app referrer - 98
  * others/unavailable - 95

# Other interesting stuff

* [Launch trailer](https://www.youtube.com/watch?v=zRMPyKmwlQc&ab_channel=GrumpyBull)
* couple of youtubers featured the game in their videos
  * [HotshotTek](https://youtu.be/MqGfSoQFxHM?t=338)
  * [SamTech](https://www.youtube.com/watch?v=-dynmrIg5Ig&ab_channel=SamTech)
  * [Another one from HotshotTek](https://youtu.be/jA-imA1HVmw?t=480)
  * interesting fact is, nobody wanted any compensation for the video, only redeem codes, thanks for that
* as expected, most downloads happened in early days after release. That was caused by a couple of (almost identical) posts into appropriate reddit communities, which performed pretty well
  * [r/apple](https://www.reddit.com/r/apple/comments/ntn0oc/space_impact_watch_epic_enough/)
  * [r/iOSProgramming](https://www.reddit.com/r/iOSProgramming/comments/nsp46j/trailer_for_my_finally_finished_little_game_epic/)
  * [r/AppleWatch](https://www.reddit.com/r/AppleWatch/comments/npy04l/trailer_for_my_little_game/) (the best one)
  * [r/IndieDev](https://www.reddit.com/r/IndieDev/comments/npxs99/trailer_for_my_little_game/)
  * [r/playmygame](https://www.reddit.com/r/playmygame/comments/npxjhd/my_small_game_is_released/)

# Technical stuff

## Stack
* swift
* sprite kit
* krita
* photopea

## How does it work

### Game loop
Let's skip menu and other boring stuff. There is actually only one game scene and content is being loaded programmatically. 
There is one huge central class for that single GameScene, which holds references to everything happening on screen. 
At the beginning it sets up scene, backgrounds, ui and player. I created a system, which spawns enemies and powerups based on some kind of prescription, which looks like this:

```
struct SpawnObject {
  let spriteOrAtlas: String //visual representation&nbsp;
  let time: TimeInterval //time when to appear
  let type: SpawnType //enemy, powerup or boss
  var y: CGFloat? = nil //initial y position
  var moves: [CGPoint]? = nil //array of points where to move sequentially
  let speed: CGFloat //speed of movement
  var health: Int? = nil //number of damage it can take
  var shootInterval: TimeInterval? = nil //time interval in ms for shooting
  var randomShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil //similar as shootInterval, but randomized and with boundaries
  var singleShootTimes: [TimeInterval]? = nil //exact times when to shoot once
  var score: Int? = nil //score for destroying this enemy
  var yOffset: Int? = nil //offset used for bosses in order to more preciselly restrict their move pattern
  var charge: (interval: TimeInterval, hideBefore: Bool)? = nil //some bosses can charge and this is the flag for that. there is also possibility to move back for a while before charging
  var randomMissleShootTimeIntervalRange: (min: TimeInterval, max: TimeInterval)? = nil //like randomShootTimeIntervalRange, but with homing missles
  var minionSpawner: (spriteOrAtlas: String, health: Int, minionSpeed: CGFloat, zigZag: Bool, score: Int, min: TimeInterval, max: TimeInterval)? = nil //like randomShootTimeIntervalRange, but with minions
}
```

Such objects are manually added to a collection and GameScene picks the correct on based on time. Creating those arrays was pretty tedious process, because I wanted the game to resemble the original as close as possible, and I had only a couple of YouTube walkthrough videos.  
So I had to watch them second by second and mark down the exact time, then spawn appears and also its speed, shooting pattern and move pattern. 
Then GameScene performed "AI" operations on every frame. This includes but it's not limited to
* enemy movement
* bullets movement
* nukes movement
* enemy shooting
* hit collisions check
By the way, hit collisions are checked manually without usage if SpriteKit colliders. Rectangular virtual colliders are used for this.

### Ranked mode

The game contains also infinite pseudo-random mode which spawns enemies for the infinite amount of time, till the player dies. Then it can upload score to Apple Game Services.
It gets also progressively harder. I created a simple system to ensure every game is the same and infinite. I randomly typed a bunch of long strings with numbers:
```
    private var seed : Decimal = Decimal(string: "12467548791243467501")!
    private var salt1 : Decimal = Decimal(string: "126549617")!
    private var salt2 : Decimal = Decimal(string: "265984797")!
```

When deciding what and when to spawn, first I created even longer string by concating, trimming and adding mentioned variables. Then I broke the result from this method into a couple of substrings. Every substring means something. 
For example first two characters represent a sprite which will be used, third one represents spawn time of next entity, fourth char decide whether the entity is an enemy or powerup etc.
It took a while to balance this system, but it works pretty well. It starts easy, but incrementally gets more and more challenging when enemies spawn faster and with more health. 

### Graphics

<img src="https://github.com/vvodicka/Space-Impact-Watch/blob/main/boss.png?raw=true"/>

Everything is handmade pixel by pixel in 1:10 ratio. That means, 1 pixel in nokia is 10 pixels in result. Such sprites are then scaled up or down based on your resolution. Game screen has the same aspect ratio as original nokia phone - 1:1.75 (84x48 pixels). This results in almost pixel perfect experience. 
Bosses were pretty challenging to create, because reference videos weren't always in the sufficient quality and I had to do a lot of trials and errors. Not mentioning, almost everything consisted from two frames making a primitive animation. And I am no graphics designer nor an artist, so this process consumed a lot of time.


# Sources

At last but not least, I decided to make it open [source](https://github.com/vvodicka/Space-Impact-Watch). Feel free to do any fun stuff you want. I would be glad if you reference this project when forked and even more for starring it.
To run the project, just checkout the repository and open `sources/Space Impact.xcworkspace`. You will need to set your own app id and development team in order to run the project. Do not hate me, if you find some slovak comments, I planed to keep it private first :)

# Future plans

<img src="https://github.com/vvodicka/Space-Impact-Watch/blob/main/snake.png?raw=true" width="256"/>

I would like to create a Snake II free DLC. That would allow you to play also a simplified version of this game inside Space Impact Watch.

# Conclusion

It was a fun doing such project alone. I received a lot of support from various communities but also some criticism for copying the existing game. Several people asked about licensing stuff. I did some search around for any licenses of this game, but I wasn't able to find anything, therefore I assumed, there is no license for good old Space Impact.
Feel free to contact me for any kind of feedback, questions or a free codes.
