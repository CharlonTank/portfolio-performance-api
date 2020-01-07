PortfolioStates::Type = GraphQL::ObjectType.define do
  name 'PortfolioState'
  field :id, !types.String
  field :final_balance, !types.Int
  field :allocations, !types[!Allocations::Type]
end
