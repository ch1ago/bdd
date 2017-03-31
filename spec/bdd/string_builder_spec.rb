require 'spec_helper'

describe Bdd::StringBuilder do
  it "works" do
    subject = Bdd::StringBuilder.new("!!!")
    expect(subject.string).to include("!!!")

    subject.append_success("SUCCESS")
    expect(subject.string).to include("SUCCESS")

    subject.append_pending("PENDING")
    expect(subject.string).to include("PENDING")

    subject.append_failure("FAILURE")
    expect(subject.string).to include("FAILURE")
  end
end
