require "rails_helper"

RSpec.describe Admin::PauseTypePresenter do
  describe "#call" do
    it "returns the pause type payload" do
      pause_type = create(
        :pause_type,
        name: "Intervalo"
      )

      result =
        described_class.new(
          pause_type: pause_type
        ).call

      expect(result).to include(
        id: pause_type.id,
        name: "Intervalo",
        has_time_limit: pause_type.has_time_limit,
        max_concurrent: pause_type.max_concurrent,
        requires_queue: pause_type.requires_queue,
        active: true
      )
    end
  end
end