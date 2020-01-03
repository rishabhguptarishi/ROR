module Admin
  class AdminBaseController < ApplicationController
    before_action :authorize_admin

    private def authorize_admin
      unless current_user.admin?
        redirect_to admin_url, notice: "You are not authorized to view admin pages"
      end
    end
  end
end
