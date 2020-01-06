PortfolioStates::Mutations::BulkCreate = GraphQL::Field.define do
  description 'creates some PortfolioStates'
  type types[PortfolioStates::Type]

  argument :portfolio_state, !types[PortfolioStates::Mutations::InputType]

  resolve ApplicationService.call(:portfolio_state, :bulk_create)
end
