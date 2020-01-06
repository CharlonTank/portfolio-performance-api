PortfolioStates::Mutations::Update = GraphQL::Field.define do
  description 'Updates a PortfolioState'
  type PortfolioStates::Type

  argument :id, types.String
  argument :portfolio_state, !PortfolioStates::Mutations::InputType

  resolve ApplicationService.call(:portfolio_state, :update)
end
