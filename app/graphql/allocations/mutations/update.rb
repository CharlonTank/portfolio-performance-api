Allocations::Mutations::Update = GraphQL::Field.define do
  description 'Updates a Allocation'
  type Allocations::Type

  argument :id, types.String
  argument :allocation, !Allocations::Mutations::InputType

  resolve ApplicationService.call(:allocation, :update)
end
