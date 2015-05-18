class PostsController < ApplicationController



  private

  def post_params
    params.require(:post).permit(:link, :title)
  end
end