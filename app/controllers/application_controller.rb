class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params, :check_inactivity_period
  before_action :set_hit_counter
  before_action :authorize, :set_action_start_time
  after_action :set_custom_header
  helper_method :hit_counter



  def current_user
    @@current_user
  end

  def hit_counter
    @@hit_counter
  end

  protected

    def check_inactivity_period
      @@start_time ||= Time.now
      if Time.now - @@start_time >= 5.minutes && current_user
        session[:user_id] = nil
        redirect_to store_index_url, notice: "Logged Out"
      end
    end

    def set_hit_counter
      @@hit_counter ||= 0
      @@hit_counter += 1
    end

    def authorize
      @@current_user = User.find_by(id: session[:user_id])
      unless @@current_user
        redirect_to login_url, notice: "Please login"
      end
    end

    def set_action_start_time
      @@start_time = Time.now
    end

    def set_custom_header
      response.headers['x-responded_in'] = Time.now - @@start_time
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
