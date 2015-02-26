require "spec_helper"

describe CommentingJob do
  it "saves the violations" do
    build = double("Build")
    violations_payload = {
        build_id: 1,
        filename: "foo.scss",
        line_number: 1,
        messages: ["I'm a teapot"],
        patch_position: 13,
    }
    allow(Violation).to receive(:create)

    CommentingJob.perform_now(build, [violations_payload].to_json)

    expect(Violation).to have_received(:create).
      with(JSON.parse(violations_payload.to_json))
  end

  it "comments on the violations"

  context "when all the build_workers are done" do
    it "updates the CI-status on GitHub as a success"
  end

  context "when all the build_workers are done" do
    it "does not update GitHub"
  end

  it "marks the build as complete"
end
