blog = angular.module('blog',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

blog.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'PostsController'
      ).when('/posts/new',
        templateUrl: "form.html"
        controller: 'PostController'
      ).when('/posts/:postId',
        templateUrl: "show.html"
        controller: 'PostController'
      ).when('/posts/:postId/edit',
        templateUrl: "form.html"
        controller: 'PostController'
      )
])

controllers = angular.module('controllers',[])