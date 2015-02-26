class CommentingJob < ActiveJob::Base
  def perform(build, violations_payload)
    create_violations(violations_payload)
  end

  private

  def create_violations(violations_payload)
    JSON.parse(violations_payload).each do |violation_payload|
      Violation.create(violation_payload)
    end
  end
end
