class TopicsController < ApplicationController
  before_action :set_topic, only: [ :show, :destroy ]
  def index
    @topics = Topic.ordered
    @topic = Topic.new
  end

  def show
    @posts = @topic.posts.ordered
    @post = @topic.posts.build
  end

  def new
    @topic = Topic.new
    @post = @topic.posts.build
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.turbo_stream
        format.html { redirect_to topics_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy

    redirect_to topics_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
