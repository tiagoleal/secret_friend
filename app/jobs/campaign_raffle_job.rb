#app/jobs/campaign_raffle_job.rb
class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  #process the queue
  def perform(campaign)
    results = RaffleService.new(campaign).call
    campaign.members.each{|m| m.set_pixel} 
    begin
      results.each do |r|
        CampaignMailer.raffle(campaign, r.first, r.last).deliver_now
      end
    rescue
      #send mail to owner of campagn (desafio)
      CampaignMailer.raffle_error(campaign).deliver_now #now send
    end
    campaign.update(status: :finished)  
  end
end

