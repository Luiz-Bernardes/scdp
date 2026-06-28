require 'rails_helper'

RSpec.describe Pauses::FinishPauseService do
  describe '#call' do
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }
    let(:pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active
      )
    end

    it 'finishes the pause' do
      described_class.new(pause: pause).call

      expect(pause.reload.status).to eq('finished')
    end

    it 'sets ended_at' do
      described_class.new(pause: pause).call

      expect(pause.reload.ended_at).to be_present
    end

    it 'processes the queue' do
      queued_user = create(:user)

      queue = create(
        :pause_queue,
        user: queued_user,
        team: team,
        pause_type: pause_type,
        status: 'waiting',
        position: 1
      )

      described_class.new(pause: pause).call

      expect(queue.reload.status).to eq('processed')
      expect(
        Pause.where(
          user: queued_user,
          pause_type: pause_type,
          status: :active
        )
      ).to exist
    end
  end
end