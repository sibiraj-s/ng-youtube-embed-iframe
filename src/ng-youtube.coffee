'use strict'

###
# define angular application
###

app = angular.module 'ngYoutube', ['ngSanitize']

app.constant 'youtubePlayerConfig',
  player: {}
  width: '100%'
  height: '100%'
  playerVars: {}

app.directive 'youtube',
['$compile', 'youtubePlayerConfig', '$window', ($compile, youtubePlayerConfig, $window) ->
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
      youtubePlayerConfig.player = new $window.YT.Player 'ngYoutube',
        videoId: playerVideoId
        height: playerHeight
        width: playerWidth
        playerVars: playerVars
        events:
          'onReady': onPlayerReady
          'onPlaybackQualityChange': onPlayerPlaybackQualityChange
          'onStateChange': onPlayerStateChange
          'onError': onPlayerError
          'onPlaybackRateChange': onPlaybackRateChange
          'onApiChange': onApiChange
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
      scope.$emit 'ngYoutubePlayer:onApiChange', youtubePlayerConfig.player
      return

    return
]

app.factory 'ytPlayer', ['youtubePlayerConfig', (youtubePlayerConfig) ->
  playVideo: ->
    youtubePlayerConfig.player.playVideo()
    return

  pauseVideo: ->
    youtubePlayerConfig.player.pauseVideo()
    return

  stopVideo: ->
    youtubePlayerConfig.player.seekTo 0
    youtubePlayerConfig.player.stopVideo()
    return

  seekTo: (seconds, allowSeekAhead) ->
    youtubePlayerConfig.player.seekTo seconds, allowSeekAhead
    return

  nextVideo: ->
    youtubePlayerConfig.player.nextVideo()
    return

  previousVideo: ->
    youtubePlayerConfig.player.previousVideo()
    return

  playVideoAt: (index) ->
    youtubePlayerConfig.player.playVideoAt index
    return

  loadVideo: (fn, args) ->
    if angular.isArray(args)
      youtubePlayerConfig.player[fn].apply(youtubePlayerConfig.player, args)
    else if angular.isObject(args)
      youtubePlayerConfig.player[fn] args
    else
      console.log 'invalid arguments'
    return

  loadPlaylist: (fn, args) ->
    if angular.isArray(args)
      youtubePlayerConfig.player[fn].apply youtubePlayerConfig.player, args
    else if angular.isObject(args)
      youtubePlayerConfig.player[fn] args
    else
      console.log 'invalid arguments'
    return

  mute: ->
    youtubePlayerConfig.player.mute()
    return

  unMute: ->
    youtubePlayerConfig.player.unMute()
    return

  isMuted: ->
    youtubePlayerConfig.player.isMuted()

  setVolume: (vol) ->
    youtubePlayerConfig.player.setVolume vol
    return

  getVolume: ->
    youtubePlayerConfig.player.getVolume()

  setSize: (width, height) ->
    youtubePlayerConfig.player.setSize width, height
    return

  getPlaybackRate: ->
    youtubePlayerConfig.player.getPlaybackRate()

  setPlaybackRate: (suggestedRate) ->
    youtubePlayerConfig.player.setPlaybackRate suggestedRate
    return

  getAvailablePlaybackRates: ->
    youtubePlayerConfig.player.getAvailablePlaybackRates()

  setLoop: (loopPlaylists) ->
    youtubePlayerConfig.player.setLoop loopPlaylists
    return

  setShuffle: (bool) ->
    youtubePlayerConfig.player.setShuffle bool
    return

  getVideoLoadedFraction: ->
    youtubePlayerConfig.player.getVideoLoadedFraction()

  getPlayerState: ->
    youtubePlayerConfig.player.getPlayerState()

  getCurrentTime: ->
    youtubePlayerConfig.player.getCurrentTime()

  setPlaybackQuality: (quality) ->
    youtubePlayerConfig.player.setPlaybackQuality quality
    return

  getPlaybackQuality: ->
    youtubePlayerConfig.player.getPlaybackQuality()

  getAvailableQualityLevels: ->
    youtubePlayerConfig.player.getAvailableQualityLevels()

  getDuration: ->
    youtubePlayerConfig.player.getDuration()

  getVideoUrl: ->
    youtubePlayerConfig.player.getVideoUrl()

  getVideoEmbedCode: ->
    youtubePlayerConfig.player.getVideoEmbedCode()

  getPlaylist: ->
    youtubePlayerConfig.player.getPlaylist()

  getPlaylistIndex: ->
    youtubePlayerConfig.player.getPlaylistIndex()

  addEventListener: (event, listener) ->
    youtubePlayerConfig.player.addEventListener event, listener
    return

  removeEventListener: (event, listener) ->
    youtubePlayerConfig.player.removeEventListener event, listener
    return

  getIframe: ->
    youtubePlayerConfig.player.getIframe()

  destroy: ->
    youtubePlayerConfig.player.destroy()
    return
]
