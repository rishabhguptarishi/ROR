class SessionsController < ApplicationController
  skip_before_action :authorize, :check_inactivity_period
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      user.update(last_activity_at: Time.now)
      if user.admin?
        redirect_to admin_reports_path
      else
        redirect_to admin_url
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged Out"
  end
end
