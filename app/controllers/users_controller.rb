class UsersController < ApplicationController
  before_action :require_admin, only: :update

  def new
    @user = invitation.users.build

    respond_to do |format|
      format.html
      format.png do
        image_stream = RQRCode::QRCode.new(new_invitation_user_url(invitation))
                                      .as_png(size: 500)
                                      .to_datastream

        send_data image_stream,
                  type: 'image/png',
                  disposition: 'inline'
      end
    end
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

  def update
    user.update!(user_params)
    redirect_to(invitations_path)
  end


  def destroy
    logout
    redirect_to root_url, notice: "Logged out"
  end

  private

  def invitation
    @invitation ||= Invitation.find_by(id: params[:invitation_id])
  end

  def user
    @user ||= invitation.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :deactivated)
  end
end
