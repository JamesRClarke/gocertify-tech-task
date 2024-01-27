module CampaignsHelper

  def table_state_colour(state:)
    state_colour_classes = {
      draft: 'text-orange-500',
      published: 'text-green-500',
      archived: 'text-slate-500'
    }

    state_colour_classes[state.to_sym] || 'text-gray-500'
  end
end
