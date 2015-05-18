app.factory('posts', ['$http', function($http){
    var o = {
      posts: []
    };
    o.getAll = function() {
      return $http.get('/posts.json').success(function(data){
        angular.copy(data, o.posts);
      });
    };
    o.create = function(new_post) {
      return $http.post('/posts.json', new_post).success(function(data){
        o.posts.push(data);
      })
    }
    return o;
  }])