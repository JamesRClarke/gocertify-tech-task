# require 'pp'
class CampaignPositionService

  def insert_and_sort(campaign:)
    @campaign = campaign
    new_position = find_campaigns_position

    # Need to extract previous pos
    previous_position = campaign.position
    campaign.update!(position: nil)

    if previous_position.nil?
      update_succeeding_positions(new_position)
    else
      update_positions_after_insertion(previous_position, new_position)
    end

    campaign.update!(position: new_position)
    # pp Campaign.not_draft.order(:published_at).pluck(:id, :published_at,:position)
  end

  def reset_all_positions
    campaigns_needing_positions = Campaign.not_draft.order(:published_at)
    campaigns_needing_positions.all.update_all(position: nil)
    campaigns_needing_positions.each_with_index do |c, index|
      c.update(position: index + 1)
    end
  end

  private
  attr_reader :campaign

  def update_succeeding_positions(new_position)
    campaigns_for_reordering.where('position >= ?', new_position).update_all('position = position + 1')
  end

  def update_positions_after_insertion(previous_position, new_position)
    if previous_position < new_position
      campaigns_for_reordering.where(position: (previous_position + 1)..new_position)
                                .update_all('position = position - 1')
    end

    if previous_position > new_position
      campaigns_for_reordering.where(position: new_position..previous_position)
                                .update_all('position = position + 1')
    end
  end

  def find_campaigns_position
    index_of_insertion = campaigns_for_reordering.index { |c| campaign.published_at < c.published_at }
    index_of_insertion += 1 if index_of_insertion == 0
    index_of_insertion || campaigns_for_reordering.count
  end

  def campaigns_for_reordering
    @campaigns_for_reordering ||= Campaign.not_draft.order(:position)
  end
end
