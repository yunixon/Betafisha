# coding: utf-8
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
    @topic = current_user.topics.build(params[:topic])
    @topic.forum = Forum.find(params[:topic][:forum_id])

    if @topic.save
      redirect_to @topic.forum, :notice => "Successfully created topic."
    else
      render 'new'
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
      render 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_url, :notice => "Successfully destroyed topic."
  end

end
