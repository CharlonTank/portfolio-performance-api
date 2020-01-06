Allocations::Mutations::Create = GraphQL::Field.define do
  description 'Creates a Allocation'
  type Allocations::Type

  argument :allocation, !Allocations::Mutations::InputType

  resolve ApplicationService.call(:allocation, :create)
end
