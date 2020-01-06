Allocations::Mutations::InputType = GraphQL::InputObjectType.define do
  name 'AllocationInputType'
  description 'Properties for updating a Allocation'

  argument :symbol, !types.String
  argument :percentage, !types.Int

end
