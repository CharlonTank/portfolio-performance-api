Allocations::Mutations::BulkCreate = GraphQL::Field.define do
  description 'creates some Allocations'
  type types[Allocations::Type]

  argument :allocation, !types[Allocations::Mutations::InputType]

  resolve ApplicationService.call(:allocation, :bulk_create)
end
