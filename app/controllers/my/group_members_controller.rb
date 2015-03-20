class My::GroupMembersController < My::ApplicationController

    # GET /groups
  # GET /groups.xml
  #before_filter :set_user
  #before_filter :authenticate_user!

  def create
    @group = Group.find params[:group_id]
    
    @group.users << current_user unless @group.users.include? current_user # add user to group if he isn't already a member

    redirect_to my_groups_url
  end

  def destroy
    @group = Group.find params[:group_id]

    @group.users.delete current_user if @group.users.include? current_user # remove user to group if he isn't already a member

    redirect_to my_groups_url
  end

  
  private

  def set_user
    @user = current_user
  end

end
