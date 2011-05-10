require 'spec_helper'

describe Build do
  describe '#create' do
    fixtures :integrations

    before do
      @integration = integrations :integration1
      @build = Build.new :integration => @integration
    end

    it 'should set #started_at before create' do
      @build.save!

      @build.started_at.should_not be_nil
      @build.started_at.should be_a_kind_of Time
    end

    it 'should set #status before create' do
      @build.save!
      @build.status.should == Build::STATUS_ENQUEUED
    end
  end
end
