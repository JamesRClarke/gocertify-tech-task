require 'rails_helper'

RSpec.describe CampaignPositionService do
  let(:subject) { described_class.new }

  describe '#insert_and_sort' do
    let!(:campaign1) { create(:campaign, state: :published, published_at: 7.days.ago, position: 1) }
    let!(:campaign2) { create(:campaign, state: :published, published_at: 5.days.ago, position: 2) }
    let!(:campaign3) { create(:campaign, state: :published, published_at: 3.days.ago, position: 3) }
    let!(:campaign4) { create(:campaign, state: :published, published_at: 1.days.ago, position: 4) }
    let!(:campaign5) { create(:campaign, state: :published, published_at: Date.today, position: 5) }
    let!(:campaign6) { create(:campaign, state: :draft, published_at: nil, position: nil) }

    context 'when campaign published_at is updated to before original publish date' do
      before do
        campaign5.update!(published_at: 6.days.ago)
         allow(campaign5).to receive(:set_position)
      end

      it 'updates positions correctly' do
        subject.insert_and_sort(campaign: campaign5)
        campaigns_position_order = Campaign.not_draft.order(:published_at).pluck(:position)

        expect(campaign5.reload.position).to eq(2)
        expect(campaigns_position_order).to eq([1,2,3,4,5])
      end
    end

    context 'when campaign published_at is updated to after original publish date' do
      before do
        campaign1.update!(published_at: 2.days.ago)
        allow(campaign1).to receive(:set_position)
      end

      it 'updates positions correctly' do
        subject.insert_and_sort(campaign: campaign1)
        campaigns_position_order = Campaign.not_draft.order(:published_at).pluck(:position)

        expect(campaign1.reload.position).to eq(3)
        expect(campaigns_position_order).to eq([1,2,3,4,5])
      end
    end

    context 'when campaign published_at is first assigned' do
      before do
        campaign6.update!(state: :published, published_at: DateTime.now)
        allow(campaign6).to receive(:set_position)
      end

      it 'updates positions correctly' do
        subject.insert_and_sort(campaign: campaign6)
        campaigns_position_order = Campaign.not_draft.order(:published_at).pluck(:position)

        expect(campaign6.reload.position).to eq(6)
        expect(campaigns_position_order).to eq([1,2,3,4,5,6])
      end
    end
  end

  describe '#reset_all_positions' do
    it 'resets all positions' do
      campaigns = create_list(:campaign, 10)
      campaigns.each_with_index { |c, index| c.update(position: index + 1) }

      subject.reset_all_positions

      campaigns.map(&:reload)
      expect(Campaign.all.order(:published_at).pluck(:position)).to eq([1,2,3,4,5,6,7,8,9,10])
    end
  end

end
