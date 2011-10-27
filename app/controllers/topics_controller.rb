class TopicsController < ApplicationController

  before_filter :authenticate

  layout 'forum'

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( params[:topic] )
    ActiveRecord::Base.logger.info params[:topic][:forum_id]
    @topic.forum_id = params[:topic][:forum_id]
    @topic.user_id = current_user.id 
    if @topic.save
      redirect_to @topic.forum, :notice => "Successfully created topic."
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to @topic, :notice  => "Successfully updated topic."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url, :notice => "Successfully destroyed topic."
  end

end
