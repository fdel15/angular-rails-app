class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :upvote]


  def index
    respond_with Post.all
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    if @post.save
      respond_with @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def show
    respond_with Post.find(params[:id])
  end

  def downvote
    post = Post.find(params[:id])
    vote = post.votes.find_by(user_id: current_user.id)
    if vote && vote.vote_type == "up"
      vote.destroy
      post = Post.find(params[:id])
    else
      post.votes.find_or_create_by(user_id: current_user.id, vote_type: "down")
    end

    respond_with post
  end

  def upvote
    post = Post.find(params[:id])
    vote = post.votes.find_by(user_id: current_user.id)
    if vote && vote.vote_type == "down"
      vote.destroy
      post = Post.find(params[:id])
    else
      post.votes.find_or_create_by(user_id: current_user.id)
    end

    respond_with post
  end


  private

  def post_params
    params.require(:post).permit(:link, :title)
  end
end