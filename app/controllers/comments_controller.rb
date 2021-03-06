class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote]


  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(comment_params.merge(user_id: current_user.id))
    respond_with post, comment
  end

  def downvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    vote = comment.votes.find_by(user_id: current_user.id)

    if vote && vote.vote_type == "up"
      vote.destroy
      comment = Comment.find(comment.id)
    else
      comment.votes.find_or_create_by(user_id: current_user.id, vote_type: "down")
    end

    respond_with post, comment
  end

  def upvote
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    vote = comment.votes.find_by(user_id: current_user.id)

    if vote && vote.vote_type == "down"
      vote.destroy
      comment = Comment.find(comment.id)
    else
      comment.votes.find_or_create_by(user_id: current_user.id)
    end

    respond_with post, comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end