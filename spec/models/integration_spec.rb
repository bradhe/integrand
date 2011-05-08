require 'spec_helper'

describe Integration do
  describe 'a new integration' do
    fixtures :integrations

    before do
      @integration = Integration.new
    end

    it 'should validate the integration name is not empty when created' do
      @integration.name = nil
      @integration.valid?
      @integration.errors.should include :name
    end

    it 'should validate that integration names are unique' do
      @integration.name = 'Some Integration'

      # Just incase the fixture changes, make sure the name equals the fixture
      @integration.name.should == integrations(:integration1).name

      # Now see if the actual validation is applied.
      @integration.valid?
      @integration.errors.should include :name
    end

    it 'should validate that the filesystem path is not empty' do
      @integration.repository = nil
      @integration.valid?
      @integration.errors.should include :repository
    end
  end
end
