module PortfolioStates
  class Service < ApplicationService

    def create
      p = PortfolioState.create(start_date: params[:start_date],
                                initial_balance: params[:initial_balance])
      params[:allocations].each do |al|
        p.allocations.create(al)
      end
      tab = {}
      final_balance = 0
      p.allocations.each do |a|
        tab[a.symbol] = HTTParty.get("https://api.worldtradingdata.com/api/v1/history?symbol=#{a.symbol}&date_from=#{params[:start_date]}&api_token=" + ENV['WORLD_TRADING_DATA_KEY'])
        if tab[a.symbol]['Message'].blank?
          final_balance += p.initial_balance * a.percentage * tab[a.symbol]['history'].values.first['close'].to_f / (100 * tab[a.symbol]['history'].values.last['close'].to_f)
        end
      end
      p.update(final_balance: final_balance)
      p
    end
  end
end
