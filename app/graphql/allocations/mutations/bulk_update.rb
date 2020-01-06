Allocations::Mutations::BulkUpdate = GraphQL::Field.define do
  description 'Updates some Allocations'
  type types[Allocations::Type]

  argument :allocation, !types[!Allocations::Mutations::InputType]

  resolve ApplicationService.call(:allocation, :bulk_update)
end
