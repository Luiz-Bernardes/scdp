require "rails_helper"

RSpec.describe "Admin::Users", type: :request do
  let!(:admin) do
    create(
      :user,
      role: :admin
    )
  end

  let!(:user) do
    create(
      :user,
      name: "Luiz",
      email: "luiz@email.com",
      role: :agent
    )
  end

  let(:token) do
    Auth::JwtService.encode(
      user_id: admin.id
    )
  end

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}"
    }
  end

  describe "GET /admin/users" do
    it "returns active users" do
      get "/admin/users",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body).to be_an(Array)
      expect(body.map { |u| u["id"] }).to include(user.id)

      expect(body.first)
        .to include(
          "id",
          "name",
          "email",
          "role",
          "active"
        )
    end

    it "does not return inactive users" do
      user.update!(
        active: false
      )

      get "/admin/users",
          headers: headers

      body =
        JSON.parse(response.body)

      ids =
        body.map { |u| u["id"] }

      expect(ids)
        .not_to include(user.id)
    end
  end

  describe "GET /admin/users/:id" do
    it "returns the user" do
      get "/admin/users/#{user.id}",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body["id"])
        .to eq(user.id)

      expect(body["name"])
        .to eq(user.name)
    end
  end

  describe "POST /admin/users" do
    it "creates a user" do
      expect {

        post "/admin/users",
             params: {
               user: {
                 name: "Pedro",
                 email: "pedro@email.com",
                 role: "agent"
               }
             },
             headers: headers

      }.to change(User, :count).by(1)
    end
  end

  describe "PATCH /admin/users/:id" do
    it "updates the user" do
      patch "/admin/users/#{user.id}",
            params: {
              user: {
                name: "Novo Nome"
              }
            },
            headers: headers

      expect(response)
        .to have_http_status(:ok)

      expect(
        user.reload.name
      ).to eq("Novo Nome")
    end
  end

  describe "DELETE /admin/users/:id" do
    it "deactivates the user" do
      delete "/admin/users/#{user.id}",
             headers: headers

      expect(response)
        .to have_http_status(:no_content)

      expect(
        user.reload.active
      ).to be(false)
    end
  end
end