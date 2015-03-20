class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  #before_filter :set_user # within public groups there is no need for a user
  #before_filter :authenticate_user!


  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end  
  
end
