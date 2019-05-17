require 'rails_helper'

RSpec.describe CampaignRaffleJob, type: :job do


  describe "#perform" do

    context "when create the job" do
      before(:each) do
        @campaign = create(:campaign)  
        create(:member, campaign: @campaign)
        @campaign = Campaign.last
        @raffle   = CampaignRaffleJob.perform_later(@campaign)
      end
      
      it "Returns job successfully scheduled" do 
        expect(@raffle.job_id).not_to be_nil
      end

      it "Return job queue name" do 
        expect(@raffle.queue_name).to eq("emails")
      end

    end


  end



end
