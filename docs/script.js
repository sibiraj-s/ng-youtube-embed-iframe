const app = angular.module('myApp', ['ngYoutube']);

app.controller('mainCtrl', ['$scope', 'ytPlayer', ($scope, ytPlayer) => {
  $scope.playerReady = false;
  $scope.ytPlayer = undefined;

  $scope.videoId = 'pRpeEdMmmQ0';

  $scope.$on('ngYoutubePlayer:onPlayerReady', () => {
    $scope.ytPlayer = ytPlayer;

    if ($scope.ytPlayer.player1) {
      $scope.playerReady = true;
      $scope.$apply();
    }
  });
}]);
