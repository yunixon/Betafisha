class PageSubjectsController < ApplicationController
 
 
  layout 'admin'
  def index
    @page_subjects = PageSubject.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @page_subject = PageSubject.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @page_subject = PageSubject.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @page_subject = PageSubject.find(params[:id])
  end


  def create
    @page_subject = PageSubject.new(params[:page_subject])

    respond_to do |format|
      if @page_subject.save
        format.html { redirect_to(@page_subject, :notice => 'Page subject was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @page_subject = PageSubject.find(params[:id])

    respond_to do |format|
      if @page_subject.update_attributes(params[:page_subject])
        format.html { redirect_to(@page_subject, :notice => 'Page subject was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @page_subject = PageSubject.find(params[:id])
    @page_subject.destroy
    respond_to do |format|
      format.html { redirect_to(page_subjects_url) }
    end
  end
end
