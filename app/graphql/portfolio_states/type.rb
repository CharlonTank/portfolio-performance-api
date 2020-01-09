PortfolioStates::Type = GraphQL::ObjectType.define do
  name 'PortfolioState'
  field :id, !types.String
  field :start_date, !types.String
  field :initial_balance, !types.Int
  field :allocations, !types[!Allocations::Type]
  field :token, types.String
end
