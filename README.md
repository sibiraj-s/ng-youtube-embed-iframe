# ng-youtube-embed-iframe [![Build Status](https://travis-ci.org/Sibiraj-S/ng-youtube-embed-iframe.svg?branch=master)](https://travis-ci.org/Sibiraj-S/ng-youtube-embed-iframe)
The ng-youtube-embed-iframe lets you embed a YouTube video player on your website and control the player using AngularJs.

Using the ng-youtube-embed-iframe functions, you can queue videos for playback; play, pause, or stop those videos, adjust the player volume, or retrieve information about the video being played. You can also add event listeners that will execute in response to certain player events, such as a player state change or a video playback quality change.

The AngularJS directive for [Youtube Iframe API][ApiReference]. All functions supported by Youtube Iframe API is supported.

## Getting started

#### Install Package
npm

```bash
npm install ng-youtube-embed-iframe --save
```

yarn

```bash
yarn add ng-youtube-embed-iframe
```

bower

```bash
bower install ng-youtube-embed-iframe --save
```

#### use package

```js
<script src="ng-youtube-embed-iframe/dist/ng-youtube.min.js"></script>

var app = angular.module('myApp', ['ngYoutube'])

<youtube></youtube> // add in html
```

also include `angular-santize`

#### options

options like `video-id, height, width` can be directly provided in the element which is considered as a main priority.

Other options can be provided in `player-options`

In HTML
```html
<youtube player-options="options"></youtube>
```

In Controller
```js
$scope.options = {
	videoId:'',
	height:'100%',
	width:'700px',
	playerVars:{} // all parameters supported by youtube-iframe-api
}
```
Check here for more [Youtube Iframe Api Parameters][Parameters]

## Functions

### Queueing functions

Queueing functions allow you to load and play a video, a playlist, or another list of videos. It supports Array and Object syntax

Check [Youtube Iframe API Queueing functions][Queue] for more information

#### Video

##### Array Syntax

```js
[videoId:String, startSeconds:Number,suggestedQuality:String]
```
##### Object Syntax

```js
{
 videoId:String,
 startSeconds:Number,
 endSeconds:Number,
 suggestedQuality:String
 }
```
#### Playlists

##### Array Syntax

```js
[playlist:String|Array, index:Number, startSeconds:Number, suggestedQuality:String]
```

##### Object Syntax

```js
{
 list:String,
 listType:String,
 index:Number,
 startSeconds:Number,
 suggestedQuality:String
 }
```

#### Usage

For Videos
supported functions are `cueVideoById, loadVideoById, cueVideoByUrl, loadVideoByUrl`

```js
loadVideo(function name , array | object)
```

For Playlists
supported functions are `cuePlaylist, loadPlaylist`

```js
loadVideo(function name , array | object)
```

### Playback controls and player settings

Define `ytPlayer` in your controller and assign it to $scope `$scope.ytPlayer = ytPlayer;`

#### Usage

```js
$scope.ytPlayer.playVideo();
```

##### Playing a video

```js
play   : playVideo();
pause  : pauseVideo();
stop   : stopVideo();
seekTo : seekTo(seconds:Number, allowSeekAhead:Boolean);
```

##### Playing a video in a playlist

```js
nextVideo     : nextVideo();
previousVideo : previousVideo();
playVideoAt   : playVideoAt(index:number);
```

##### Changing the player volume

```js
mute      : mute();
unMute    : unMute();
isMuted   : isMuted();
setVolume : setVolume(volume:number);
getVolume : getVolume();
```

##### Setting the player size

```js
setSize : setSize(width, height)
```
##### Setting the playback rate

```js
getPlaybackRate           : getPlaybackRate();
setPlaybackRate           : setPlaybackRate(playback_rate);
getAvailablePlaybackRates : getAvailablePlaybackRates();
```

##### Setting playback behaviour for playlists

```js
setLoop    : setLoop(loopPlaylists:Boolean);
setShuffle : setShuffle(shufflePlaylist:Boolean);
```

##### Playback status

```js
getVideoLoadedFraction : getVideoLoadedFraction();
getPlayerState         : getPlayerState();
getCurrentTime         : getCurrentTime();
```

##### Playback quality

```js
getPlaybackQuality        : getPlaybackQuality();
setPlaybackQuality        : setPlaybackQuality(suggestedQuality:String);
getAvailableQualityLevels : getAvailableQualityLevels();
```

###### Retrieving video information

```js
getDuration       : getDuration();
getVideoUrl       : getVideoUrl();
getVideoEmbedCode : getVideoEmbedCode();
```

##### Retrieving playlist information

```js
getPlaylist      : getPlaylist();
getPlaylistIndex : getPlaylistIndex();
```

##### Adding or removing an event listener

```js
addEventListener    : addEventListener(event:String, listener:String);
removeEventListener : removeEventListener(event:String, listener:String);
```

##### Accessing and modifying DOM nodes

```js
getIframe : getIframe();
destroy   : destroy();
```

## Events

Check [Youtube Iframe API Events][Events] for more details and usage options.

The API fires events to notify your application of changes to the embedded player. The events can be received by following methods

#### onReady

This event fires whenever a player has finished loading and is ready to begin receiving API calls.

```js
ngYoutubePlayer:onPlayerReady

// sample
$scope.$on('ngYoutubePlayer:onPlayerReady', function() {
    console.log('player ready');
});
```
#### onStateChange

This event fires whenever the player's state changes.

```js
ngYoutubePlayer:onPlayerStateChange
```

you can also watch for particular events on state change such as

```js
ngYoutubePlayer:PLAYING
ngYoutubePlayer:ENDED
ngYoutubePlayer:UNSTARTED
ngYoutubePlayer:PAUSED
ngYoutubePlayer:BUFFERING
ngYoutubePlayer:CUED
```

#### onPlayerPlaybackQualityChange
This event fires whenever the video playback quality changes.

```js
ngYoutubePlayer:onPlayerPlaybackQualityChange
```

#### onPlaybackRateChange

This event fires whenever the video playback rate changes.

```js
ngYoutubePlayer:onPlaybackRateChange
```

#### onPlayerError

This event fires if an error occurs in the player.

```js
ngYoutubePlayer:onPlayerError
```

#### onApiChange

This event is fired to indicate that the player has loaded (or unloaded) a module with exposed API methods.

```js
ngYoutubePlayer:onApiChange
```

The following command retrieves an array of module names for which you can set player options:

```js
$scope.ytPlayer.getOptions();
```

Example: to retrieve in particular

```js
getOptions('captions');
```

Retrieving an option:

```js
getOption(module, option);
```

Setting an option

```js
setOption(module, option, value);
```


[ApiReference]:https://developers.google.com/youtube/iframe_api_reference
[Events]:https://developers.google.com/youtube/iframe_api_reference#Events
[Queue]:https://developers.google.com/youtube/iframe_api_reference#Queueing_Functions
[Parameters]:https://developers.google.com/youtube/player_parameters
