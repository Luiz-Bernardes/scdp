require "rails_helper"

RSpec.describe "Pauses::Reserve", type: :request do
  describe "POST /pauses/reserve" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true
      )
    end

    let(:token) do
      Auth::JwtService.encode(user_id: user.id)
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "creates a reserved pause" do
      post "/pauses/reserve",
           params: {
             pause_type_id: pause_type.id,
             selected_duration_minutes: 10
           },
           headers: headers

      expect(response).to have_http_status(:created)

      pause = Pause.last

      expect(pause.user).to eq(user)
      expect(pause.pause_type).to eq(pause_type)

      expect(pause.status).to eq("reserved")
      expect(pause.selected_duration_minutes).to eq(10)

      expect(pause.started_at).to be_nil
      expect(pause.expires_at).to be_nil
      expect(pause.ended_at).to be_nil
    end

    it "returns error when duration is missing" do
      post "/pauses/reserve",
           params: {
             pause_type_id: pause_type.id
           },
           headers: headers

      expect(response).to have_http_status(:unprocessable_content)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Duration is required")
    end

    it "does not allow reserving a second slot" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      post "/pauses/reserve",
           params: {
             pause_type_id: pause_type.id,
             selected_duration_minutes: 10
           },
           headers: headers

      expect(response).to have_http_status(:unprocessable_content)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("User already has an active pause")
    end

    it "creates a queue entry when the limit is reached and queue is enabled" do
      pause_type.update!(
        max_concurrent: 1,
        requires_queue: true
      )

      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      expect {
        post "/pauses/reserve",
             params: {
               pause_type_id: pause_type.id,
               selected_duration_minutes: 10
             },
             headers: headers
      }.to change(PauseQueue, :count).by(1)

      expect(response).to have_http_status(:created)

      queue = PauseQueue.last

      expect(queue.user).to eq(user)
      expect(queue.pause_type).to eq(pause_type)
      expect(queue.position).to eq(1)
      expect(queue.status).to eq("waiting")
    end
    
  end
end