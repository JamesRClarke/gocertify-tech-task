class Campaign < ApplicationRecord
  validates :position, uniqueness: { allow_blank: true }
  after_save :set_position

  enum :state, { draft: 0, published: 1, archived: 2 }

  scope :ordered_position_asc, -> { order(position: :asc) }
  scope :ordered_position_desc, -> { order(position: :desc) }

  private

  def set_position
    return if state == :draft
    return unless saved_change_to_published_at?

    CampaignPositionService.new.insert_and_sort(campaign: self)
  end
end
