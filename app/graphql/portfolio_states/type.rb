PortfolioStates::Type = GraphQL::ObjectType.define do
  name 'PortfolioState'
  field :id, !types.String
  field :allocation_ids, types[types.String] do
    resolve CollectionIdsResolver
  end
  field :allocations, types[Allocations::Type]
  field :created_at, types.String
  field :updated_at, types.String
  field :initial_balance, types.Int
end
