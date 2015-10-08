class FriendablesController < ApplicationController
  def create
    @friendables = current_user.friendables.build(:friend_id => params[:friend_id], accepted: "false")
    binding.pry
    if @friendables.save
      flash[:notice] = "Friend Requested."
      redirect_to :back
    else
      flash[:notice] = "Unable to request friendship."
      redirect_to :back
    end
  end

  def update
    @friendable = Friendable.where(friend_id: current_user, user_id: params[:id]).first
    @friendable.update(accepted: true)
      if @friendable.save
        redirect_to root_url, :notice => "Succesfully confirmed friend!"
      else
        redirect_to root_url, :notice => "Sorry! Could not confirm friend!"
      end
  end

  def destroy
    @friendable = Friendable.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendable.destroy
    flash[:notice] = "Removed friendable."
    redirect_to :back
  end
end
