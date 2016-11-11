require 'rails_helper'
require 'spec_helper'

RSpec.describe RedeemifyCodesController, type: :request do
  describe "GET /users/:user_id/redeemify_codes/:code" do

    before do
      @user   = FactoryGirl.create :user, name: 'Joe'
      @rcode  = FactoryGirl.create :redeemify_code, { code: '1234', user_id: @user.id }
      @vcode  = FactoryGirl.create :vendor_code, { code: 'asdf', user_id: @user.id }

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "returns success" do
      get '/redeemify_codes/:id', format: :json, params: { id: @rcode.code }
      expect(response).to have_http_status(200)
    end

    it "returns the bundled codes" do
      get '/redeemify_codes/:id', format: :json, params: { id: @rcode.code }
      body = JSON.parse(response.body)
      code_value = body['code'] #['data']['attributes']['code']
      expect(code_value) == 'asdf'
    end
  end
end
