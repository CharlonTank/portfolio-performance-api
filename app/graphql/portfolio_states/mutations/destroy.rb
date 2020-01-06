PortfolioStates::Mutations::Destroy = GraphQL::Field.define do
  description 'Destroys a PortfolioState'
  type PortfolioStates::Type

  argument :id, !types.String

  resolve ApplicationService.call(:portfolio_state, :destroy)
end
