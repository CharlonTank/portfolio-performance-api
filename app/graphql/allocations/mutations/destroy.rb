Allocations::Mutations::Destroy = GraphQL::Field.define do
  description 'Destroys a Allocation'
  type Allocations::Type

  argument :id, !types.String

  resolve ApplicationService.call(:allocation, :destroy)
end
