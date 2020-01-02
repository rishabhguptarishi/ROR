module Admin
  class ReportsController < AdminBaseController

    def index
      from = params[:start_date] ? Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i) : Time.now.beginning_of_day
      to = params[:end_date] ? Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i) : from - 5.days
      @orders = Order.by_date(from, to)
    end
  end
end
