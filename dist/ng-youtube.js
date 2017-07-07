
/*
 * @module ng-youtube-embed-iframe
 * @description The AngularJS directive for youtube-iframe-player-api
 * @version v1.1.2
 * @link https://github.com/Sibiraj-S/ng-youtube-embed-iframe
 * @licence MIT License, https://opensource.org/licenses/MIT
 */

(function() {
  'use strict';
  var $youtube, $youtubePlayerConfig;

  $youtubePlayerConfig = function() {
    return {
      width: '100%',
      height: '100%',
      playerVars: {}
    };
  };

  $youtube = function($compile, ytPlayer, youtubePlayerConfig, $window) {
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
          ytPlayer = new $window.YT.Player('ngYoutube', {
            videoId: playerVideoId,
            height: playerHeight,
            width: playerWidth,
            playerVars: playerVars,
            events: {
              onReady: onPlayerReady,
              onPlaybackQualityChange: onPlayerPlaybackQualityChange,
              onStateChange: onPlayerStateChange,
              onError: onPlayerError,
              onPlaybackRateChange: onPlaybackRateChange,
              onApiChange: onApiChange
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
          scope.$emit('ngYoutubePlayer:onApiChange', ytPlayer);
        };
        scope.$on('$destroy', function() {
          $window.ytPlayer && $window.ytPlayer.destroy();
          $window.YT = void 0;
        });
      }
    };
  };


  /*
   * dependency injection
   */

  $youtube.$inject = ['$compile', 'ytPlayer', 'youtubePlayerConfig', '$window'];


  /*
   * define angular application
   */

  angular.module('ngYoutube', ['ngSanitize']).directive('youtube', $youtube).constant('youtubePlayerConfig', $youtubePlayerConfig).constant('ytPlayer');

}).call(this);
