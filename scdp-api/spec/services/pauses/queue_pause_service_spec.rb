require 'rails_helper'

RSpec.describe Pauses::QueuePauseService do
  describe '#call' do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }

    it 'creates a queue entry' do
      queue = described_class.new(
        user: user,
        pause_type: pause_type
      ).call

      expect(queue).to be_persisted
      expect(queue.position).to eq(1)
      expect(queue.status).to eq('waiting')
    end

    it 'increments position correctly' do
      create(
        :pause_queue,
        pause_type: pause_type,
        team: team,
        position: 1
      )

      queue = described_class.new(
        user: user,
        pause_type: pause_type
      ).call

      expect(queue.position).to eq(2)
    end
  end
end