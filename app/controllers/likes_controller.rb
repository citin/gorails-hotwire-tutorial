class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.increment!(:likes)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@post, partial: "posts/post", locals: { post: @post }) }
      format.html { redirect_to @post }
    end
  end
end
