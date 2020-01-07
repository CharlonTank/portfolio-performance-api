Allocations::Type = GraphQL::ObjectType.define do
  name 'Allocation'
  field :symbol, !types.String
  field :percentage, !types.Int
  field :price_per_times, !types[!PricePerTimes::Type]
end
