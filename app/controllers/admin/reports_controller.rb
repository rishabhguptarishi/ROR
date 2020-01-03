module Admin
  class ReportsController < AdminBaseController

    def index
      from,to = prepare_date_range(params)
      @orders = Order.by_date(from, to)
    end

    private def prepare_date_range(params)
      start_date = params[:start_date] ? generate_date_from_params(params[:start_date]) : Time.now.beginning_of_day
      end_date = params[:end_date] ? generate_date_from_params(params[:end_date]) : start_date - 5.days
      return start_date, end_date
    end

    private def generate_date_from_params(date_hash)
      Date.civil(date_hash[:year].to_i, date_hash[:month].to_i, date_hash[:day].to_i)
    end
  end
end
