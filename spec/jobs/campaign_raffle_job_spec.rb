require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    @campaign = create(:campaign)  
    @member   = create(:member, campaign: @campaign)
    @raffle   = CampaignRaffleJob.perform_later(@campaign)
  end

  describe "#perform" do
    context "when create the job" do
      it "Returns job successfully scheduled" do 
        ActiveJob::Base.queue_adapter = :test
        expect {
          CampaignRaffleJob.perform_later('raffle')
        }.to have_enqueued_job
      end
    end
  end
end
