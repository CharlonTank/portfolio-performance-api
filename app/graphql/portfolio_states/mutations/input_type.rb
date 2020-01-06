PortfolioStates::Mutations::InputType = GraphQL::InputObjectType.define do
  name 'PortfolioStateInputType'
  description 'Properties for updating a PortfolioState'
  argument :allocation_ids, types[types.String]

  argument :initial_balance, types.Int

end
