# ng-youtube-embed-iframe [![Tests](https://github.com/sibiraj-s/ng-youtube-embed-iframe/workflows/Tests/badge.svg)](https://github.com/sibiraj-s/ng-youtube-embed-iframe/actions) [![Jsdelivr](https://data.jsdelivr.com/v1/package/npm/ng-youtube-embed-iframe/badge?style=rounded)](https://www.jsdelivr.com/package/npm/ng-youtube-embed-iframe)

<p align="center">
  <a href="https://github.com/sibiraj-s/ng-youtube-embed-iframe">
   <img src="https://raw.githubusercontent.com/sibiraj-s/ng-youtube-embed-iframe/master/assets/images/youtube.png" alt="ng-youtube-embed-iframe" height="180">
  </a>
</p>

ng-youtube-embed-iframe lets you embed a YouTube video player on your website and control the player using AngularJs.

Using ng-youtube-embed-iframe functions, you can queue videos for playback; play, pause, or stop those videos, adjust the player volume, or retrieve information about the video being played. You can also add event listeners that will execute in response to certain player events, such as a player state change or a video playback quality change.

An AngularJS directive for [Youtube Iframe API][yt-apireference]. All functions supported by Youtube Iframe API is supported.

## Getting started

### Installation

Installation can be done via Package managers such as [npm][npm] or [yarn][yarn]

```bash
npm install ng-youtube-embed-iframe --save
# or
yarn add ng-youtube-embed-iframe
```

or use cdn

##### Minified

```bash
//cdn.jsdelivr.net/npm/ng-youtube-embed-iframe@latest/ng-youtube.min.js
```

##### Pretty Printed

```bash
//cdn.jsdelivr.net/npm/ng-youtube-embed-iframe@latest/ng-youtube.js
```

### Usage

Include the modules required for ng-youtube-embed-iframe.

```html
<script src="angular/angular.min.js"></script>
<script src="../ng-youtube.min.js"></script>
```

add `ngYoutube` dependency to the module

```js
angular.module('myApp', ['ngYoutube']);
```

and in your html

```html
<youtube id="myYoutubePlayer" video-id="{{videoId}}"></youtube>
```

#### options

Options like `video-id, height, width` can be directly provided in the element which is considered as the main priority.

Other options can be provided in `player-options`

In HTML

```html
<youtube player-options="options" id="myYoutubePlayer"></youtube>
```

In Controller

```js
$scope.options = {
  videoId: '',
  height: '100%',
  width: '700px',
  playerVars: {} // all parameters supported by youtube-iframe-api
};
```

Refer [wiki][wiki] for documentation

[yt-apireference]: https://developers.google.com/youtube/iframe_api_reference
[wiki]: https://github.com/sibiraj-s/ng-youtube-embed-iframe/wiki
[npm]: https://www.npmjs.com/
[yarn]: https://yarnpkg.com/lang/en/
