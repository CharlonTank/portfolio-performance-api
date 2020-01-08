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
      tab = {}
      p_openstruct = OpenStruct.new(final_balance: 0, allocations: [])
      params[:allocations].each do |a|
        tab[a['symbol']] = HTTParty.get("https://api.worldtradingdata.com/api/v1/history?symbol=#{a['symbol']}&date_from=#{params[:start_date]}&api_token=" + ENV['WORLD_TRADING_DATA_KEY'])
        next unless tab[a['symbol']]['Message'].blank?

        p_openstruct[:final_balance] += params[:initial_balance] * a['percentage'] * tab[a['symbol']]['history'].values.first['close'].to_f / (100 * tab[a['symbol']]['history'].values.last['close'].to_f)
        al_openstruct = OpenStruct.new(symbol: a['symbol'],
                                       percentage: a['percentage'],
                                       price_per_times: [])
        tab[a['symbol']]['history'].map do |k, v|
          al_openstruct[:price_per_times] <<
          OpenStruct.new(value: v['close'], time: k)
        end
        p_openstruct.allocations << al_openstruct
      end
      p_openstruct[:token] = p&.id
      p_openstruct[:start_date] = params[:start_date]
      p_openstruct[:initial_balance] = params[:initial_balance]
      p_openstruct
    end

    def show
      p = PortfolioState.find_by(id: params[:id])
      p_openstruct = OpenStruct.new(final_balance: 0, allocations: [])
      tab = {}
      p&.allocations&.each do |a|
        tab[a['symbol']] = HTTParty.get("https://api.worldtradingdata.com/api/v1/history?symbol=#{a['symbol']}&date_from=#{p&.start_date}&api_token=" + ENV['WORLD_TRADING_DATA_KEY'])
        next unless tab[a['symbol']]['Message'].blank?

        p_openstruct[:final_balance] += p.initial_balance * a['percentage'] * tab[a['symbol']]['history'].values.first['close'].to_f / (100 * tab[a['symbol']]['history'].values.last['close'].to_f)
        al_openstruct = OpenStruct.new(symbol: a['symbol'],
                                       percentage: a['percentage'],
                                       price_per_times: [])
        tab[a['symbol']]['history'].map do |k, v|
          al_openstruct[:price_per_times] <<
            OpenStruct.new(value: v['close'], time: k)
        end
        p_openstruct.allocations << al_openstruct
      end
      p_openstruct[:token] = p&.id
      p_openstruct[:start_date] = p&.start_date
      p_openstruct[:initial_balance] = p&.initial_balance
      p_openstruct
    end
  end

end
