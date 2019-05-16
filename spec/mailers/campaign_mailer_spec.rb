#/spec/mailer/campaign_mailer_spec.rb
require "rails_helper"

RSpec.describe CampaignMailer, type: :mailer do
  
  before do
    @campaign = create(:campaign)
    @member = create(:member, campaign: @campaign)
    @friend = create(:member, campaign: @campaign)
    @email = CampaignMailer.raffle(@campaign,@member,@friend)
    @email_error = CampaignMailer.raffle_error(@campaign)
  end

  describe 'raffle' do
  
    it 'renders the headers' do
      expect(@email.subject).to eq("Nosso Amigo Secreto: #{@campaign.title}")
      expect(@email.to).to eq([@member.email])
    end

    it 'body have member name' do
      expect(@email.body.encoded).to match(@member.name)
    end

    it 'body have campaign creator name' do
      expect(@email.body.encoded).to match(@campaign.user.name)
    end

    it 'body have member link to set open' do
      expect(@email.body.encoded).to match("/members/#{@member.token}/opened")
    end
  end

  describe "raffle error" do

    it 'renders the headers' do
      expect(@email_error.subject).to eq("Erro no sorteio do Nosso Amigo Secreto")
      expect(@email_error.to).to eq([@campaign.user.email])
    end

    it 'body have campaign creator name' do
      expect(@email_error.body.encoded).to match(@campaign.user.name)
    end

  end
end
