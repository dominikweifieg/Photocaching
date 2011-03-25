class ContactController < ApplicationController
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    Contact.contact(params[:sender_email], params[:sender_name], params[:subject], params[:type], params[:body]).deliver
    respond_to do |format|
      format.html { redirect_to(:action => :index) }
    end  
  end
  
  def index
  end

end
