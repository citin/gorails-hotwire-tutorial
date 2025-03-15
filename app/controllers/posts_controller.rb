class PostsController < ApplicationController
  before_action :set_topic
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params)

    respond_to do |format|
      if @post.save
        @post.broadcast_prepend_to @topic, :posts, locals: { post: @post, is_author: false }

        format.turbo_stream
        format.html { redirect_to topic_path(@topic), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.broadcast_update_to @topic, :posts, locals: { post: @post, is_author: false }

        format.turbo_stream
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!
    @post.broadcast_remove_to @topic, :posts
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params.require(:id))
  end

  def set_topic
    @topic = Topic.find(params.require(:topic_id))
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :topic).merge(author: Current.user)
  end
end
