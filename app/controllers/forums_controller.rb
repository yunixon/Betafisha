class ForumsController < ApplicationController
  
  before_filter :authenticate, :except => [:index, :show]

  uses_tiny_mce

  layout 'forum'

  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect_to forums_path, :notice => "Successfully created forum."
    else
      render :action => 'new'
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update_attributes(params[:forum])
      redirect_to forums_path, :notice  => "Successfully updated forum."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy
    redirect_to forums_path, :notice => "Successfully destroyed forum."
  end


end
