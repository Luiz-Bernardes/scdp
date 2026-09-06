require 'rails_helper'

RSpec.describe 'Admin::PauseTypes', type: :request do
  let!(:admin) { create(:user, role: :admin) }
  let!(:team) { create(:team, created_by: admin) }

  describe 'GET /admin/pause_types' do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it 'returns pause types' do
      get '/admin/pause_types'

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.length).to eq(1)
      expect(body.first['id']).to eq(pause_type.id)
      expect(body.first['name']).to eq(pause_type.name)
      expect(body.first['team_id']).to eq(team.id)
      expect(body.first['team_name']).to eq(team.name)
    end
  end

  describe 'GET /admin/pause_types/:id' do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it 'returns the pause type' do
      get "/admin/pause_types/#{pause_type.id}"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body['id']).to eq(pause_type.id)
      expect(body['name']).to eq(pause_type.name)
      expect(body['team_id']).to eq(team.id)
      expect(body['team_name']).to eq(team.name)
    end
  end

  describe 'POST /admin/pause_types' do
    let(:params) do
      {
        pause_type: {
          name: 'Intervalo 10 minutos',
          team_id: team.id,
          has_time_limit: true,
          max_duration_minutes: 10,
          max_concurrent: 2,
          requires_queue: true,
          active: true
        }
      }
    end

    it 'creates a pause type' do
      expect {
        post '/admin/pause_types', params: params
      }.to change(PauseType, :count).by(1)

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)

      expect(body['name']).to eq('Intervalo 10 minutos')
      expect(body['team_id']).to eq(team.id)
      expect(body['has_time_limit']).to eq(true)
      expect(body['max_duration_minutes']).to eq(10)
      expect(body['max_concurrent']).to eq(2)
      expect(body['requires_queue']).to eq(true)
      expect(body['active']).to eq(true)
    end
  end

  describe 'PATCH /admin/pause_types/:id' do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team,
        name: 'Intervalo 10 minutos',
        has_time_limit: true,
        max_duration_minutes: 10,
        max_concurrent: 2,
        requires_queue: true
      )
    end

    let(:params) do
      {
        pause_type: {
          name: 'Intervalo 20 minutos',
          max_duration_minutes: 20,
          max_concurrent: 1,
          requires_queue: false
        }
      }
    end

    it 'updates the pause type' do
      patch "/admin/pause_types/#{pause_type.id}", params: params

      expect(response).to have_http_status(:ok)

      pause_type.reload

      expect(pause_type.name).to eq('Intervalo 20 minutos')
      expect(pause_type.max_duration_minutes).to eq(20)
      expect(pause_type.max_concurrent).to eq(1)
      expect(pause_type.requires_queue).to eq(false)
    end
  end

  describe 'DELETE /admin/pause_types/:id' do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it 'deletes the pause type' do
      expect {
        delete "/admin/pause_types/#{pause_type.id}"
      }.to change(PauseType, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end