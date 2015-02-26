require "spec_helper"

describe BuildWorker do
  it { should validate_presence_of :build }
  it { should belong_to :build }
end
