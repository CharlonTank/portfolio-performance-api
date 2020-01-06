PortfolioStates::Mutations::Create = GraphQL::Field.define do
  description 'Creates a PortfolioState'
  type PortfolioStates::Type

  argument :portfolio_state, !PortfolioStates::Mutations::InputType

  resolve ApplicationService.call(:portfolio_state, :create)
end
