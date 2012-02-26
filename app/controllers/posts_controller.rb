# coding: utf-8
class PostsController < ApplicationController

  before_filter :authenticate#, :only => [:edit, :update]
  #before_filter :admin_user, :only => [:destroy]

  layout 'forum'

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    @post.topic = Topic.find(params[:post][:topic_id])

    if @post.save
      redirect_to @post.topic, :notice => "Successfully created post."
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
end
