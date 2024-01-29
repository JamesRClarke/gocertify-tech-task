module CampaignsHelper

  def campaign_state_colour(state:)
    state_colour_classes = {
      draft: 'text-orange-500',
      published: 'text-green-500',
      archived: 'text-slate-500'
    }

    state_colour_classes[state.to_sym] || 'text-gray-500'
  end

  def published_at_formatted(time:)
    return 'Unpublished' if !time

    time.strftime("#{time.day.ordinalize} %B %Y at %I:%M%p")
  end
end
