const app = angular.module('myApp', ['ngYoutube']);

const mainCtrl = ($scope, ytPlayer) => {
  $scope.playerReady = false;
  $scope.ytPlayer = undefined;

  $scope.videoId = '6ZfuNTqbHE8';

  $scope.$on('ngYoutubePlayer:onPlayerReady', () => {
    $scope.ytPlayer = ytPlayer;

    if ($scope.ytPlayer.player1) {
      $scope.playerReady = true;
      $scope.$apply();
    }
  });
};

mainCtrl.$inject = ['$scope', 'ytPlayer'];
app.controller('mainCtrl', mainCtrl);
