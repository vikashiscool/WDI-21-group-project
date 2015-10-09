class FriendablesController < ApplicationController
  def create
    @friendables = current_user.friendables.build(:friend_id => params[:friend_id], accepted: "false")
    if @friendables.save
      flash[:notice] = "Friend Requested."
      redirect_to user_path(@friendables.friend_id)
    else
      flash[:notice] = "Unable to request friendship."
      redirect_to :back
    end
  end

  def update
    @friendable = Friendable.where(user_id: current_user.id, friend_id: params[:id].to_i)
    @friendable.first.update(accepted: true)
      if @friendable.first.save
        redirect_to user_path(current_user.id), :notice => "Succesfully confirmed friend!"
      else
        redirect_to user_path(current_user.id), :notice => "Sorry! Could not confirm friend!"
      end
  end

  def destroy
    @friendable = Friendable.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendable.destroy
    flash[:notice] = "Removed friendable."
    redirect_to :back
  end

  private
  def friendable_params
    params.require(:friendable).permit(:accepted)
  end
end
