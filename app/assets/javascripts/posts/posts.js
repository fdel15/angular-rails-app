app.factory('posts', ['$http', function($http){
    var o = {
      posts: []
    };
    return o;
  }])