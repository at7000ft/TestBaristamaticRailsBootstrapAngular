//
// Define the Baristamatic module, dependencies and specify client side routes to html templates in the templates dir
// $routeProvider and  $locationProvider are injected by Angular.
//
var app = angular.module('Baristamatic', [
    'ngRoute',
    'templates',
    'ngResource'
]);

app.config(function ( $routeProvider, $locationProvider) {
    console.log('barista-app>>app.js: config func running');
    $routeProvider
        .when('/baristamatic', {
            templateUrl: 'baristamatic.html',
            controller: 'BaristamaticCtrl'
        })
       .when('/baristamatic/about', {
          templateUrl: 'about.html'
       })
       .when('/baristamatic/blog', {
          templateUrl: 'blog.html'
       })
       .when('/baristamatic/contact', {
          templateUrl: 'contact.html'
       })
        .otherwise({
            redirectTo: '/baristamatic'
        });
    $locationProvider.html5Mode(true);
});

app.run(function () {
    //Write message to Inspect browser console
    console.log('barista-app>>app.js: angular app running');
});