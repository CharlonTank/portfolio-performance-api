class PortfolioState < ApplicationRecord

  has_many :allocations, dependent: :destroy
end
