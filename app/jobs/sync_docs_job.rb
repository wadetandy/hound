class SyncDocsJob < ApplicationJob
  queue_as :medium

  def perform(payload_data)
    payload = Payload.new(payload_data)
    build_runner = DocSyncRunner.new(payload)
    build_runner.run
  end
end
