require 'rails_helper'

RSpec.describe "Mes", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/me/show"
      expect(response).to have_http_status(:success)
    end
  end

end
