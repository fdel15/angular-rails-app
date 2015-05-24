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
      return $http.post('/posts.json', new_post)
        .success(function(data){
        o.posts.push(data);
      })
        .error(function(err){
          if(err.link) { alert("Link " + err.link[0])}
          else if(err.title) { alert("Title " + err.title[0])}
          else { alert("Whoops! Something went wrong. Please log in and try again.")};
        })
    }
    o.upvote = function(post) {
      return $http.post('/posts/' + post.id + '/upvote.json')
       .success(function(data){
        post.number_of_votes = data.number_of_votes;
       });
    }
    o.downvote = function(post) {
      return $http.post('/posts/' + post.id + '/downvote.json')
        .success(function(data){
          post.number_of_votes = data.number_of_votes
        })
    }
    o.get_single_post = function(id) {
      return $http.get('/posts/' + id + '.json').then(function(res){
        return res.data;
      })
    }
    o.addComment = function(id, comment){
      return $http.post('/posts/' + id + '/comments.json', comment);
    };

    o.upvoteComment = function(post, comment) {
      return $http.post('/posts/' + post.id + '/comments/' + comment.id + '/upvote.json')
        .success(function(data){
          comment.number_of_votes = data.number_of_votes;
        });
    };
    o.downvoteComment = function(post, comment) {
      return $http.post('/posts/' + post.id + '/comments/' + comment.id + '/downvote.json')
        .success(function(data){
          comment.number_of_votes = data.number_of_votes
        });
    }
    return o;
  }])