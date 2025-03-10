class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.update(likes: @post.likes + 1)
  end
end
