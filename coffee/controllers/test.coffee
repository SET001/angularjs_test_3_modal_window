app.controller 'testCtrl', ['$rootScope', 'TestModal', ($scope, TestModal) ->

  $scope.example1 = ->
    TestModal.openAlert 'Some alert message'
      
  $scope.example2 = ->
    TestModal.openConfirm('Do you want to hire me?').then ->
      alert 'Goood news )'
    , ->
      alert 'Bad news *('

  $scope.example3 = ->
    TestModal.open
      title: 'Send a comment'
      templateUrl: 'templates/sendmail.html'
      buttons: [
        label: 'Send'
        callback: ->
          @close()
      ]
]