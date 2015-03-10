controllers = angular.module('controllers')
controllers.controller("PostController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Post = $resource('/posts/:postId', { postId: "@id", format: 'json' },
      {
        'save':   {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.postId
      Post.get({postId: $routeParams.postId},
        ( (post)-> $scope.post = post ),
        ( (httpResponse)->
          $scope.post = null
          flash.error   = "There is no post with ID #{$routeParams.postId}"
        )
      )
    else
      $scope.post = {}

    $scope.back   = -> $location.path("/")
    $scope.edit   = -> $location.path("/posts/#{$scope.post.id}/edit")
    $scope.cancel = ->
      if $scope.post.id
        $location.path("/posts/#{$scope.post.id}")
      else
        $location.path("/")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Something went wrong"
      if $scope.post.id
        $scope.post.$save(
          ( ()-> $location.path("/posts/#{$scope.post.id}") ),
          onError)
      else
        Post.create($scope.post,
          ( (newPost)-> $location.path("/posts/#{newPost.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.post.$delete()
      $scope.back()


])