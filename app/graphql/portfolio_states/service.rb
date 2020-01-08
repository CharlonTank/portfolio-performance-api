module PortfolioStates
  class Service < ApplicationService

    def create
      if params[:save]
        p = PortfolioState.find_by(id: params[:token])
        p&.allocations&.destroy_all
        p ||= PortfolioState.create
        params[:allocations].each do |al|
          p.allocations.create(al)
        end
        p.update(start_date: params[:start_date],
                 initial_balance: params[:initial_balance])
      end
      create_open_struct_portfolio(params[:allocations],
                                   params[:initial_balance],
                                   params[:start_date],
                                   p&.id)
    end

    def show
      p = PortfolioState.find_by(id: params[:id])
      create_open_struct_portfolio(p&.allocations, p&.initial_balance,
                                   p&.start_date, params[:token])
    end

    private

    def create_open_struct_portfolio(allocations, initial_balance, start_date, token)
      tab = {}
      p_openstruct = OpenStruct.new(final_balance: 0, allocations: [])
      allocations.each do |a|
        tab[a['symbol']] = HTTParty.get("https://api.worldtradingdata.com/api/v1/history?symbol=#{a['symbol']}&date_from=#{start_date}&api_token=" + ENV['WORLD_TRADING_DATA_KEY'])
        next unless tab[a['symbol']]['Message'].blank?

        first_close_value = tab[a['symbol']]['history'].values.first['close'].to_f
        last_close_value = tab[a['symbol']]['history'].values.last['close'].to_f
        p_openstruct[:final_balance] += initial_balance * a['percentage'] *
                                        first_close_value / (100 * last_close_value)
        al_openstruct = OpenStruct.new(symbol: a['symbol'],
                                       percentage: a['percentage'],
                                       price_per_times: [])
        tab[a['symbol']]['history'].map do |k, v|
          al_openstruct[:price_per_times] <<
            OpenStruct.new(value: v['close'], time: k)
        end
        p_openstruct.allocations << al_openstruct
      end
      p_openstruct[:token] = token
      p_openstruct[:start_date] = start_date
      p_openstruct[:initial_balance] = initial_balance
      p_openstruct
    end
  end
end
