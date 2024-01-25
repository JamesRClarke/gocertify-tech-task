class Campaign < ApplicationRecord
  validates :position, uniqueness: true

  enum :state, { draft: 0, published: 1, archived: 2 }

  private

end
