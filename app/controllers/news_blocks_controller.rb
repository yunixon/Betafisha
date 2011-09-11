class NewsBlocksController < ApplicationController

  def index
    @news_blocks = NewsBlock.all
    @counter = NewsBlock.all.count
    @sports = Sport.all
  end

  def show
  @title = I18n.t(:top_menu_coefficients)
    @sports = Sport.all
    @news_block = NewsBlock.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where( :news_block_id => @news_block.id  )
  end

  def new

    @news_block = NewsBlock.new
      	render :layout => 'admin'
  end

  def create
    @news_block = NewsBlock.new(params[:news_block])
    if @news_block.save
      redirect_to @news_block, :notice => "Successfully created news block."
    else
      render :action => 'new', :layout => 'admin'
    end
  end

  def edit
    @news_block = NewsBlock.find(params[:id])
    render :layout => 'admin'
  end


  def update
    @news_block = NewsBlock.find(params[:id])

    if @news_block.update_attributes(params[:news_block])
      redirect_to @news_block, :notice  => "Successfully updated news block."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @news_block = NewsBlock.find(params[:id])
    @news_block.destroy
    redirect_to news_blocks_url, :notice => "Successfully destroyed news block."
  end

end

