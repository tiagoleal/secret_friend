require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  
  describe "POST #create" do
   
    before(:each) do
      request.env["HTTP_ACCEPT"] = 'application/json'
      @campaign = create(:campaign, user: @current_user)
      @new_member_attributes = attributes_for(:member, campaign: @campaign)
      post :create, params: {member: @new_member_attributes}
    end
    
    it { expect{ create(:member,campaign: @campaign) }.to change { Member.count }.by(1) }
    
  end

  describe "GET #destroy" do
    before(:each) do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    
    context "Delete Member of the campaign" do
      it "returns http forbidden" do
        member = create(:member)
        delete :destroy, params: {id: member.id }
        expect(response).to have_http_status(:forbidden)
      end
    end


  end

  
  describe "PUT #update" do

    before(:each) do
      @new_member_attributes = attributes_for(:member)
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "edit attributes of the member" do
      before(:each) do 
        campaign = create(:campaign, user: @current_user)
        member = create(:member, campaign:campaign)
        put :update, params: {id: member.id, member: @new_member_attributes}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "Member have the new attributes" do
        expect(Member.last.name).to  eq(@new_member_attributes[:name])
        expect(Member.last.email).to eq(@new_member_attributes[:email])
      end
    
    end  


  end
  
end
