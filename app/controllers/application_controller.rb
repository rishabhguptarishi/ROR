class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize

  def current_user
    @@current_user
  end

  protected
    def authorize
      @@current_user = User.find_by(id: session[:user_id])
      unless @@current_user
        redirect_to login_url, notice: "Please login"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
end
