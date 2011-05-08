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

#    it 'should validate that the filesystem path is not empty' do
#      @integration.path = nil
#      @integation.valid?
#      @integration.errors.should inlude :path
#    end
#
#    it 'should validate the filesystem path is writable' do
#      @integration.path = 'junk filesystem location'
#      @integration.valid?
#      @integration.errors.should include :path
#    end

    it 'should not allow new integrations to be created without source repository info' do
      @integration.source_repository = nil
      @integration.valid?
      @integration.errors.should include :source_repository
    end

  end
end
