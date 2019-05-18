class PagesController < ApplicationController
  def home
    @campaign = Campaign.where(status: :finished).order(id: :desc).limit(10)
    p @campaign.count
  end
end
