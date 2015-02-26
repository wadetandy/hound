require "spec_helper"

describe BuildWorkersController do
  describe "#update" do
    context "given an uncompleted build" do
      it "completes the build" do
        build_worker = create(:build_worker)

        put :update, id: build_worker.id, violations: []

        expect(build_worker.reload.completed_at?).to eq true
      end
    end

    context "given an completed build" do
      it "does not complete the build" do
        build_worker = create(
          :build_worker,
          :completed,
          completed_at: 1.day.ago,
        )

        put :update, id: build_worker.id, violations: []

        expect(response.status).to eq 412
        expect(build_worker.completed_at).to be < Time.now
        expect(json_body["error"]).to eq(
          "Build##{build_worker.id} has already been finished"
        )
      end
    end

    it "dispatches a commenting job to act on the violations" do
      build_worker = create(:build_worker)
      build = build_worker.build
      violations_payload = [
        {
          build_id: build.id.to_s,
          filename: "foo.scss",
          line_number: 1,
          messages: ["I'm a teapot"],
          patch_position: 13,
        },
      ].to_json
      allow(CommentingJob).to receive(:perform_later)

      put :update, id: build_worker.id, violations: violations_payload

      expect(CommentingJob).to have_received(:perform_later).
        with(build_worker.reload, violations_payload)
    end
  end
end
