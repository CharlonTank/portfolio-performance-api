Allocations::Type = GraphQL::ObjectType.define do
  name 'Allocation'
  field :id, !types.String
  field :portfolio_state_id, types.String
  field :portfolio_state, PortfolioStates::Type
  field :created_at, types.String
  field :updated_at, types.String
  field :symbol, types.String
  field :percentage, types.Int
end
