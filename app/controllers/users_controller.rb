class UsersController < ApplicationController
  def new
    @user = invitation.users.build
  end

  def create
    @user = invitation.users.build(user_params)

    if @user.save
      auto_login(@user, should_remember: true)
      redirect_to root_path, notice: 'User was created'
    else
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "Logged out"
  end

  private

  def invitation
    @invitation = Invitation.find_by(id: params[:invitation_id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
