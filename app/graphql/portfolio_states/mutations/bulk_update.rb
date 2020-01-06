PortfolioStates::Mutations::BulkUpdate = GraphQL::Field.define do
  description 'Updates some PortfolioStates'
  type types[PortfolioStates::Type]

  argument :portfolio_state, !types[PortfolioStates::Mutations::InputType]

  resolve ApplicationService.call(:portfolio_state, :bulk_update)
end
