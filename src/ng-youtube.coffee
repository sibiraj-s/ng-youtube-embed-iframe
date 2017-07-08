'use strict'

$youtubePlayerConfig = ->
  width: '100%'
  height: '100%'
  playerVars: {}

$youtube = ($compile, ytPlayer, youtubePlayerConfig, $window) ->
  restrict: 'EA'
  transclude: true
  template: '<div id="ngYoutube"></div>'
  scope:
    height: '@'
    width: '@'
    videoId: '@'
    playerOptions: '=?'
  link: (scope) ->

    ###
    # load the Youtube IFrame Player API code asynchronously
    # load page only once
    ###

    if typeof $window.YT is 'undefined' or typeof $window.YT.Player is 'undefined'
      tag = document.createElement('script')
      tag.src = 'https://www.youtube.com/iframe_api'
      firstScriptTag = document.getElementsByTagName('script')[0]
      firstScriptTag.parentNode.insertBefore tag, firstScriptTag

    ###
    # check for parameters assigned to the element
    # if assigned use the parameters
    # else if use parameters are defined in options
    # else use default parameters
    ###

    scope.playerOptions = if scope.playerOptions then scope.playerOptions else {}

    playerVideoId = if scope.videoId then scope.videoId else
      scope.playerOptions.videoId

    playerHeight = if scope.height then scope.height else
      (tempHeight = if scope.playerOptions.height then scope.playerOptions.height else
        youtubePlayerConfig.height)

    playerWidth = if scope.width then scope.width else
      (tempWidth = if scope.playerOptions.width then scope.playerOptions.width else
        youtubePlayerConfig.width)

    playerVars = if scope.playerOptions.playerVars then scope.playerOptions.playerVars else
      youtubePlayerConfig.playerVars

    ###
    # create iframe and append video url to it
    ###

    $window.onYouTubeIframeAPIReady = ->
      ytPlayer = new $window.YT.Player 'ngYoutube',
        videoId: playerVideoId
        height: playerHeight
        width: playerWidth
        playerVars: playerVars
        events:
          onReady: onPlayerReady
          onPlaybackQualityChange: onPlayerPlaybackQualityChange
          onStateChange: onPlayerStateChange
          onError: onPlayerError
          onPlaybackRateChange: onPlaybackRateChange
          onApiChange: onApiChange
      return
    ###
    # events emit by youtube iframe api
    ###

    onPlayerReady = (event) ->
      scope.$emit 'ngYoutubePlayer:onPlayerReady', event
      return

    onPlayerPlaybackQualityChange = (event) ->
      scope.$emit 'ngYoutubePlayer:onPlayerPlaybackQualityChange', event
      return

    onPlayerStateChange = (event) ->
      scope.$emit 'ngYoutubePlayer:onPlayerStateChange', event

      switch event.data
        when $window.YT.PlayerState.PLAYING
          scope.$emit 'ngYoutubePlayer:PLAYING', event
        when $window.YT.PlayerState.ENDED
          scope.$emit 'ngYoutubePlayer:ENDED', event
        when $window.YT.PlayerState.UNSTARTED
          scope.$emit 'ngYoutubePlayer:UNSTARTED', event
        when $window.YT.PlayerState.PAUSED
          scope.$emit 'ngYoutubePlayer:PAUSED', event
        when $window.YT.PlayerState.BUFFERING
          scope.$emit 'ngYoutubePlayer:BUFFERING', event
        when $window.YT.PlayerState.CUED
          scope.$emit 'ngYoutubePlayer:CUED', event
      return

    onPlayerError = (event) ->
      scope.$emit 'ngYoutubePlayer:onPlayerError', event
      return

    onPlaybackRateChange = (event) ->
      scope.$emit 'ngYoutubePlayer:onPlaybackRateChange', event
      return

    onApiChange = ->
      scope.$emit 'ngYoutubePlayer:onApiChange', ytPlayer
      return

    scope.$on '$destroy', ->
      $window.ytPlayer and $window.ytPlayer.destroy()
      $window.YT = undefined
      return

    return

###
# dependency injection
###
$youtube.$inject = ['$compile', 'ytPlayer', 'youtubePlayerConfig', '$window']

###
# define angular application
###
angular.module 'ngYoutube', ['ngSanitize']
  .directive('youtube', $youtube)
  .constant('youtubePlayerConfig', $youtubePlayerConfig)
  .constant 'ytPlayer'
