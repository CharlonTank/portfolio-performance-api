PricePerTimes::Type = GraphQL::ObjectType.define do
  name 'PricePerTime'
  field :value, !types.Float
  field :time, !types.String
end
