PortfolioStates::Mutations::InputType = GraphQL::InputObjectType.define do
  name 'PortfolioStateInputType'
  description 'Properties for updating a PortfolioState'
  argument :allocations, !types[!Allocations::Mutations::InputType]

  argument :initial_balance, !types.Int
  argument :start_date, !types.String
  argument :save, !types.Boolean
  argument :token, types.String

end
