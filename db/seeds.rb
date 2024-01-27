def generate_campaigns
  states = Campaign.states
  # If you desire a seed with completely random data, uncomment below
  # 15.times do
  #   create_campaign(state: states.sample)
  # end

  # I want to emulate a "real life" situation for you to ensure we get atleast some states across the board
  3.times do
    create_campaign(state: states["archived"])
  end

  4.times do
    create_campaign(state: states["draft"])
  end

  8.times do
    create_campaign(state: states["published"])
  end
end

def random_date
  rand(1.month.ago..Time.now)
end

def create_campaign(state:)
  published_at = state == 0 ? nil : random_date

  Campaign.create!(
    title: Faker::Movie.title,
    description: Faker::ChuckNorris.fact,
    state: state,
    published_at: published_at,
    # callback in campaign.rb, yes its heavy operation, this will only be heavy when seeding due to calling the service for each creation in one transaction
    position: nil
  )
end

Campaign.all.destroy_all
generate_campaigns
CampaignPositionService.new.reset_all_positions





