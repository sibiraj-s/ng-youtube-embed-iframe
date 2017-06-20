(function() {
  'use strict';

  /*
   * define angular application
   */
  var app;

  app = angular.module('ngYoutube', ['ngSanitize']);

  app.constant('youtubePlayerConfig', {
    player: {},
    width: '100%',
    height: '100%',
    playerVars: {}
  });

  app.directive('youtube', [
    '$compile', 'youtubePlayerConfig', '$window', function($compile, youtubePlayerConfig, $window) {
      return {
        restrict: 'EA',
        transclude: true,
        template: '<div id="ngYoutube"></div>',
        scope: {
          height: '@',
          width: '@',
          videoId: '@',
          playerOptions: '=?'
        },
        link: function(scope) {

          /*
           * load the Youtube IFrame Player API code asynchronously
           * load page only once
           */
          var firstScriptTag, onApiChange, onPlaybackRateChange, onPlayerError, onPlayerPlaybackQualityChange, onPlayerReady, onPlayerStateChange, playerHeight, playerVars, playerVideoId, playerWidth, tag, tempHeight, tempWidth;
          if (typeof $window.YT === 'undefined' || typeof $window.YT.Player === 'undefined') {
            tag = document.createElement('script');
            tag.src = 'https://www.youtube.com/iframe_api';
            firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
          }

          /*
           * check for parameters assigned to the element
           * if assigned use the parameters
           * else if use parameters are defined in options
           * else use default parameters
           */
          scope.playerOptions = scope.playerOptions ? scope.playerOptions : {};
          playerVideoId = scope.videoId ? scope.videoId : scope.playerOptions.videoId;
          playerHeight = scope.height ? scope.height : (tempHeight = scope.playerOptions.height ? scope.playerOptions.height : youtubePlayerConfig.height);
          playerWidth = scope.width ? scope.width : (tempWidth = scope.playerOptions.width ? scope.playerOptions.width : youtubePlayerConfig.width);
          playerVars = scope.playerOptions.playerVars ? scope.playerOptions.playerVars : youtubePlayerConfig.playerVars;

          /*
           * create iframe and append video url to it
           */
          $window.onYouTubeIframeAPIReady = function() {
            youtubePlayerConfig.player = new $window.YT.Player('ngYoutube', {
              videoId: playerVideoId,
              height: playerHeight,
              width: playerWidth,
              playerVars: playerVars,
              events: {
                'onReady': onPlayerReady,
                'onPlaybackQualityChange': onPlayerPlaybackQualityChange,
                'onStateChange': onPlayerStateChange,
                'onError': onPlayerError,
                'onPlaybackRateChange': onPlaybackRateChange,
                'onApiChange': onApiChange
              }
            });
          };

          /*
           * events emit by youtube iframe api
           */
          onPlayerReady = function(event) {
            scope.$emit('ngYoutubePlayer:onPlayerReady', event);
          };
          onPlayerPlaybackQualityChange = function(event) {
            scope.$emit('ngYoutubePlayer:onPlayerPlaybackQualityChange', event);
          };
          onPlayerStateChange = function(event) {
            scope.$emit('ngYoutubePlayer:onPlayerStateChange', event);
            switch (event.data) {
              case $window.YT.PlayerState.PLAYING:
                scope.$emit('ngYoutubePlayer:PLAYING', event);
                break;
              case $window.YT.PlayerState.ENDED:
                scope.$emit('ngYoutubePlayer:ENDED', event);
                break;
              case $window.YT.PlayerState.UNSTARTED:
                scope.$emit('ngYoutubePlayer:UNSTARTED', event);
                break;
              case $window.YT.PlayerState.PAUSED:
                scope.$emit('ngYoutubePlayer:PAUSED', event);
                break;
              case $window.YT.PlayerState.BUFFERING:
                scope.$emit('ngYoutubePlayer:BUFFERING', event);
                break;
              case $window.YT.PlayerState.CUED:
                scope.$emit('ngYoutubePlayer:CUED', event);
            }
          };
          onPlayerError = function(event) {
            scope.$emit('ngYoutubePlayer:onPlayerError', event);
          };
          onPlaybackRateChange = function(event) {
            scope.$emit('ngYoutubePlayer:onPlaybackRateChange', event);
          };
          onApiChange = function() {
            scope.$emit('ngYoutubePlayer:onApiChange', youtubePlayerConfig.player);
          };
        }
      };
    }
  ]);

  app.factory('ytPlayer', [
    'youtubePlayerConfig', function(youtubePlayerConfig) {
      return {
        playVideo: function() {
          youtubePlayerConfig.player.playVideo();
        },
        pauseVideo: function() {
          youtubePlayerConfig.player.pauseVideo();
        },
        stopVideo: function() {
          youtubePlayerConfig.player.seekTo(0);
          youtubePlayerConfig.player.stopVideo();
        },
        seekTo: function(seconds, allowSeekAhead) {
          youtubePlayerConfig.player.seekTo(seconds, allowSeekAhead);
        },
        nextVideo: function() {
          youtubePlayerConfig.player.nextVideo();
        },
        previousVideo: function() {
          youtubePlayerConfig.player.previousVideo();
        },
        playVideoAt: function(index) {
          youtubePlayerConfig.player.playVideoAt(index);
        },
        loadVideo: function(fn, args) {
          if (angular.isArray(args)) {
            youtubePlayerConfig.player[fn].apply(youtubePlayerConfig.player, args);
          } else if (angular.isObject(args)) {
            youtubePlayerConfig.player[fn](args);
          } else {
            console.log('invalid arguments');
          }
        },
        loadPlaylist: function(fn, args) {
          if (angular.isArray(args)) {
            youtubePlayerConfig.player[fn].apply(youtubePlayerConfig.player, args);
          } else if (angular.isObject(args)) {
            youtubePlayerConfig.player[fn](args);
          } else {
            console.log('invalid arguments');
          }
        },
        mute: function() {
          youtubePlayerConfig.player.mute();
        },
        unMute: function() {
          youtubePlayerConfig.player.unMute();
        },
        isMuted: function() {
          return youtubePlayerConfig.player.isMuted();
        },
        setVolume: function(vol) {
          youtubePlayerConfig.player.setVolume(vol);
        },
        getVolume: function() {
          return youtubePlayerConfig.player.getVolume();
        },
        setSize: function(width, height) {
          youtubePlayerConfig.player.setSize(width, height);
        },
        getPlaybackRate: function() {
          return youtubePlayerConfig.player.getPlaybackRate();
        },
        setPlaybackRate: function(suggestedRate) {
          youtubePlayerConfig.player.setPlaybackRate(suggestedRate);
        },
        getAvailablePlaybackRates: function() {
          return youtubePlayerConfig.player.getAvailablePlaybackRates();
        },
        setLoop: function(loopPlaylists) {
          youtubePlayerConfig.player.setLoop(loopPlaylists);
        },
        setShuffle: function(bool) {
          youtubePlayerConfig.player.setShuffle(bool);
        },
        getVideoLoadedFraction: function() {
          return youtubePlayerConfig.player.getVideoLoadedFraction();
        },
        getPlayerState: function() {
          return youtubePlayerConfig.player.getPlayerState();
        },
        getCurrentTime: function() {
          return youtubePlayerConfig.player.getCurrentTime();
        },
        setPlaybackQuality: function(quality) {
          youtubePlayerConfig.player.setPlaybackQuality(quality);
        },
        getPlaybackQuality: function() {
          return youtubePlayerConfig.player.getPlaybackQuality();
        },
        getAvailableQualityLevels: function() {
          return youtubePlayerConfig.player.getAvailableQualityLevels();
        },
        getDuration: function() {
          return youtubePlayerConfig.player.getDuration();
        },
        getVideoUrl: function() {
          return youtubePlayerConfig.player.getVideoUrl();
        },
        getVideoEmbedCode: function() {
          return youtubePlayerConfig.player.getVideoEmbedCode();
        },
        getPlaylist: function() {
          return youtubePlayerConfig.player.getPlaylist();
        },
        getPlaylistIndex: function() {
          return youtubePlayerConfig.player.getPlaylistIndex();
        },
        addEventListener: function(event, listener) {
          youtubePlayerConfig.player.addEventListener(event, listener);
        },
        removeEventListener: function(event, listener) {
          youtubePlayerConfig.player.removeEventListener(event, listener);
        },
        getIframe: function() {
          return youtubePlayerConfig.player.getIframe();
        },
        destroy: function() {
          youtubePlayerConfig.player.destroy();
        }
      };
    }
  ]);

}).call(this);
