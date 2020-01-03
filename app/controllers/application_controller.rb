class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :update_hit_counter
  before_action :authorize, :check_inactivity_period
  around_action :set_custom_header
  helper_method :hit_counter



  def current_user
    @@current_user ||= nil
  end

  def hit_counter
    @@hit_counter
  end

  protected

    def check_inactivity_period
      if current_user
        if Time.now - current_user.last_activity_at >= 5.minutes
          reset_session
          redirect_to store_index_url, notice: "Logged Out"
        else
          current_user.update(last_activity_at: Time.now)
        end
      end
    end

    def update_hit_counter
      @@hit_counter ||= 0
      @@hit_counter += 1
    end

    def authorize
      @@current_user = User.find_by(id: session[:user_id])
      unless @@current_user
        redirect_to login_url, notice: "Please login"
      end
    end

    def set_custom_header
      start_time = Time.now
      yield
      response.headers['X-responded_in'] = Time.now - start_time
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
